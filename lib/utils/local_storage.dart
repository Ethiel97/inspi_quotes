import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _isFirstLaunch = "AppFirstLaunch";
  static const String _authToken = "token";
  static const String _publicKey = "publicKey";
  static const String themeStatus = 'THEME_STATUS';

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static setDarkTheme(bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(themeStatus, value);
    await prefs.reload();
  }

  // static Future
  static Future<bool> getIsFirstLaunch() async {
    final prefs = await getSharedPreferences();
    return prefs.getBool(_isFirstLaunch) ?? true;
  }

  static Future<void> saveToken(token) async {
    final prefs = await getSharedPreferences();

    await prefs.setString(_authToken, token);
    await prefs.reload();
  }

  static Future<void> savePublicKey(publicKey) async {
    final prefs = await getSharedPreferences();

    await prefs.setString(_publicKey, publicKey);
    await prefs.reload();
  }

  static Future<void> clearToken() async {
    final prefs = await getSharedPreferences();

    prefs.remove(_authToken);
  }

  static Future<Object?> getToken() async {
    final prefs = await getSharedPreferences();
    return prefs.get(_authToken);
  }

  static Future<bool> isAuthenticated() async {
    final prefs = await getSharedPreferences();

    return prefs.getString(_authToken) != null;
  }

  static Future<void> setIsFirstLaunch(bool value) async {
    final prefs = await getSharedPreferences();

    prefs.setBool(_isFirstLaunch, value);
    await prefs.reload();
  }

  static saveData(String key, dynamic value) async {
    final prefs = await getSharedPreferences();
    await prefs.setString(key, jsonEncode(value));
    await prefs.reload();
  }

  static Future<dynamic> getData(String key) async {
    final prefs = await getSharedPreferences();
    var value = prefs.getString(key);
    return json.decode(value!);
  }

  static Future<void> clearData(String key) async {
    final prefs = await getSharedPreferences();
    prefs.remove(key);
  }
}
