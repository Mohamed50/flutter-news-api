/// continas the supported languages codes
List<String> supportedLanguages = ['ar','en'];
/// continas the supported languages names
List<String> supportedLanguagesNames = ['العربية','English'];

/// receive the language code and return the language name
getLanguageName(String langCode){
  return supportedLanguagesNames.elementAt(supportedLanguages.indexWhere((element) => element == langCode));
}
