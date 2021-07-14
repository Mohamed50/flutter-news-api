import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/config/language.dart';
import 'package:news_app/data/resources/pref-manager.dart';

/// a view model class for managing Theme, language, version info and notifying the UI when some data changes
class SettingViewModel with ChangeNotifier{
  /// object from the sharedPreference manager
  PrefManager _prefManager = PrefManager();

  /// object hold the theme mode of the application
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  /// object hold the locale of the selected language in the application
  Locale _locale = Locale("en");
  Locale get locale => _locale;

  /// list of all the supported language in the application
  List<Locale> _supportedLocales;
  List<Locale> get supportedLocales => _supportedLocales;

  /// the translation values of the selected language
  Map _localizedValues;
  Map get localizedValues => _localizedValues;

  /// initializing the view model
  /// fetching the user theme mode and language
  SettingViewModel(){
    fetchThemeMode();
    fetchSupportedLanguages();
  }



  // Theme Management_______________________________________________________
  /// fetching the user prefered theme form the shared preference and set it as theme mode
  void fetchThemeMode() async {
    String preferredTheme = await _prefManager.getString("theme") ?? "light";
    if (preferredTheme == "light") {
      toLight();
    } else {
      toDark();
    }
  }

  /// check if theme mode is dark
  bool isDark() {
    return themeMode == ThemeMode.dark;
  }

  /// change theme to dark theme
  void toDark() async {
    await _prefManager.setString("theme", "dark");
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  /// change theme to light theme
  void toLight() async {
    await _prefManager.setString("theme", "light");
    _themeMode = ThemeMode.light;
    notifyListeners();
  }



  // Language Management_______________________________________________________
  /// fetching the supported language in the application
  void fetchSupportedLanguages() async {
    _supportedLocales = supportedLanguages
        .map((supportedLanguage) => Locale(supportedLanguage))
        .toList();
  }

  /// fetch user preferred language and set it as application language
  void fetchPreferredLanguage() async {
    String lang = await _prefManager.get('language',supportedLanguages[0]);
    _locale = Locale(lang);
    notifyListeners();
  }

  /// set language as preferred language in shared preference
  void setPreferredLanguage(String lang){
    _prefManager.set('language', lang);
  }

  /// change the application language to received language
  void changeLanguage(String lang) async {
    _locale = Locale(lang);
    String jsonContent = await rootBundle.loadString("locale/i18n_${_locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    notifyListeners();
  }

  /// change language from arabic to english and vice versa
  void switchLanguage(){
    if (locale.languageCode == "en") {
      changeLanguage("ar");
    } else {
      changeLanguage("en");
    }
  }

  /// search the localized values for a word translation.
  /// return the same word if translation not found
  String translate(String key) {
    if(_localizedValues == null || _localizedValues[key] == null)
      return key;
    else
      return _localizedValues[key];
  }

  /// check if the selected language is a RTL language
  bool isRtl(){
    return _locale.languageCode == "ar";
  }

}