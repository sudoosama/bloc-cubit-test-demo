// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> getInstance() async {
    if (_prefsInstance == null) {
      _prefsInstance = await SharedPreferences.getInstance();
    } else {
      _prefsInstance = await _instance;
    }
    return _prefsInstance;
  }

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  //***************** FOR STRING *****************//

  static Future<String> getString(String key) async {
    var pref = await getInstance();
    return pref!.getString(key) ?? "";
  }

  static setString(String key, String? value) async {
    var pref = await getInstance();
    pref!.setString(key, value ?? '');
  }

  //***************** FOR BOOL *****************//
  static Future<bool> getBool(String key) async {
    var pref = await getInstance();
    return pref!.getBool(key) ?? false;
  }

  static setBool(String key, bool value) async {
    var prefs = await _instance;
    prefs.setBool(key, value);
  }

  //***************** FOR INT *****************//
  static Future<int> getInt(String key) async {
    var pref = await getInstance();
    return pref!.getInt(key) ?? 0;
  }

  static setInt(String key, int value) async {
    var prefs = await _instance;
    prefs.setInt(key, value);
  }

  //***************** CLEAR SHARED PREF *****************//
  static clearSharedPref() async {
    var pref = await getInstance();
    pref!.clear();
  }

  //***************** CLEAR SHARED PREF *****************//
  static removeSharedPref() async {
    var pref = await getInstance();
    pref!.remove(PrefKey.USERTOKEN);
  }

  //***************** USER LOGIN CHECKER *****************//
  static Future<bool> isLoggedIn() async {
    final String userToken = await getString(PrefKey.USERTOKEN);
    return userToken.isNotEmpty;
  }
}

class PrefKey {
  static const String USERTOKEN = 'sID';
  static const String USERNAME = 'userNmae';
  static const String PHONE_NUMBER = 'phoneNumber';
  static const String FULL_NAME = 'fullName';
}
