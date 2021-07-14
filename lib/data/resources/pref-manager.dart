import 'package:shared_preferences/shared_preferences.dart';

/// class used to manage all the SharedPreferences interactions
class PrefManager {

  /// remove a value from SharedPreferences using value key
  Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  /// set dynamic value to SharedPreferences using key and value
  Future<bool> set(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is bool) {
      return await prefs.setBool(key, value);
    }
    return false;
  }

  /// get dynamic value from SharedPreferences using key
  Future<dynamic> get(String key, dynamic defaultVal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key)){
      return prefs.get(key);
    } else {
      return defaultVal;
    }
  }

  /// set a string value in SharedPreferences
  setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// get a string value form SharedPreferences
  getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// set a integer value inside SharedPreferences
  setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  /// get integer value from SharedPreferences
  getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  /// check if key exist in SharedPreferences
  Future<bool> contains(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  /// remove all the data in the SharedPreferences
  Future clear() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.clear();
  }

}
