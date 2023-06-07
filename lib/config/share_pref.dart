import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();



  static readBool(String key) async {
    return _preferences.getBool(key) ?? false;
  }



  static saveString(String key, value) async {
    await _preferences.setString(key, json.encode(value));
  }
  static readString(String key) async {
    return _preferences.getString(key) != null
        ? json.decode(_preferences.getString(key)!)
        : null;
  }

  static saveBool(String key, value) async {
    await _preferences.setBool(key, value);
  }

  static saveList(String key, value) async {
    await _preferences.setStringList(key, value);
  }
  static readList(String key) async {
    return _preferences.getString(key)??[];
  }

  static remove(String key) async {
    _preferences.remove(key);
  }
  static clear() async {
    _preferences.clear();
  }

}
