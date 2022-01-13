import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final Preferences _singleton = Preferences._internal();

  Preferences._internal();

  //This is what's used to retrieve the instance through the app
  static Preferences getInstance() => _singleton;

  static SharedPreferences? _prefs;

  initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //The test to actually see if there is a connection
  Future<bool> setBoolValue(String key, bool value) async {
    try {
      if (_prefs == null) throw Exception("prefs not initialize yet.");

      return await _prefs!.setBool(key, value);
    } catch (e) {
      return false;
    }
  }

  Future<bool> getBoolValue(String key) async {
    try {
      if (_prefs == null) await initialize();
      if (_prefs == null) throw Exception("prefs not initialize yet.");

      return _prefs!.getBool(key) ?? false;
    } catch (e) {
      return false;
    }
  }

  void clear() async {
    try {
      if (_prefs == null) throw Exception("prefs not initialize yet.");

      _prefs!.clear();
      return;
    } catch (e) {
      return;
    }
  }
}
