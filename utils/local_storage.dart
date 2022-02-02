import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _isFirstLaunch = "AppFirstLaunch";
  static const String _authToken = "token";
  static const String _publicKey = "publicKey";
  static const String _userDocId = 'USER_ID';
  static const String THEME_STATUS = 'THEME_STATUS';
  static const String IS_FCM_TOKEN_SAVED = 'FcmTokenSaved';
  static const String IS_LOCATION_SAVED = 'IsLocationSaved';
  static const String IS_FCM_TOKEN_PUSHED = 'IsFcmTokenPushed';
  static const String IS_PHONE_ALREADY_VERIFIED = 'IsPhoneAlreadyVerified';
  static const String WARNED_AUTO_MEDICATION = 'warnedAutoMedication';
  static const String USER_WELCOMED = 'userWelcomed';
  static const String SOCKET_ID = 'socketId';
  static const String KNOWN_DISEASES = 'knownDiseases';
  static const String EMERGENCY_CASE_CONTACTS = 'emergencyCaseContacts';
  static const String FIRST_TIME_WARNED_ABOUT_PENDING_STATUS =
      'firstTimeWarnedAboutPendingStatus';

  static const String FIRST_TIME_WARNED_ABOUT_HEALTH_BOOK =
      'firstTimeWarnedAboutHealthBook';

  static const String FIRST_TIME_WARNED_ABOUT_PENDING_PRO_STATUS =
      'firstTimeWarnedAboutPendingProStatus';

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static setPhoneAlreadyVerified(bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(IS_PHONE_ALREADY_VERIFIED, value);
  }

  static setFistTimeWarnedAboutPendingStatus(bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(FIRST_TIME_WARNED_ABOUT_PENDING_STATUS, value);
  }

  static setFistTimeWarnedAboutHealthBook(bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(FIRST_TIME_WARNED_ABOUT_HEALTH_BOOK, value);
  }

  static setFistTimeWarnedAboutPendingProStatus(bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(FIRST_TIME_WARNED_ABOUT_PENDING_PRO_STATUS, value);
  }

  static setUserWelcomed(bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(USER_WELCOMED, value);
  }

  static setWarnedAutoMedication(bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(WARNED_AUTO_MEDICATION, value);
  }

  static setDarkTheme(bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(THEME_STATUS, value);
    await prefs.reload();
  }

  static Future<bool> getTheme() async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  static Future<bool> getUserWelcomed() async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getBool(USER_WELCOMED) ?? false;
  }

  static Future<bool> getWarnedAutoMedication() async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getBool(WARNED_AUTO_MEDICATION) ?? false;
  }

  // static Future
  static Future<bool> getIsFirstLaunch() async {
    final prefs = await getSharedPreferences();
    return prefs.getBool(_isFirstLaunch) ?? true;
  }

  static Future<bool> getFistTimeWarnedAboutPendingStatus() async {
    final prefs = await getSharedPreferences();
    return prefs.getBool(FIRST_TIME_WARNED_ABOUT_PENDING_STATUS) ?? true;
  }

  static Future<bool> getFistTimeWarnedAboutPendingProStatus() async {
    final prefs = await getSharedPreferences();
    return prefs.getBool(FIRST_TIME_WARNED_ABOUT_PENDING_PRO_STATUS) ?? true;
  }

  static Future<bool> getFistTimeWarnedAboutHealthBook() async {
    final prefs = await getSharedPreferences();
    return prefs.getBool(FIRST_TIME_WARNED_ABOUT_HEALTH_BOOK) ?? true;
  }

  static Future<bool> getIsPhoneAlreadyVerified() async {
    final prefs = await getSharedPreferences();
    return prefs.getBool(IS_PHONE_ALREADY_VERIFIED) ?? false;
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

  static Future<void> saveUserId(userId) async {
    final prefs = await getSharedPreferences();

    prefs.setString(_userDocId, userId);
    await prefs.reload();
  }

  static Future<void> getUserId(userId) async {
    final prefs = await getSharedPreferences();

    prefs.getString(_userDocId);
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

  static Future<bool> getIsFcmTokenSaved() async {
    final prefs = await getSharedPreferences();

    return prefs.getBool(IS_FCM_TOKEN_SAVED) ?? false;
  }

  static Future<void> setIsFcmTokenSaved(bool val) async {
    final prefs = await getSharedPreferences();

    prefs.setBool(IS_FCM_TOKEN_SAVED, val);
    await prefs.reload();
  }

  static Future<bool> getIsFcmTokenPushed() async {
    final prefs = await getSharedPreferences();

    return prefs.getBool(IS_FCM_TOKEN_PUSHED) ?? false;
  }

  static Future<void> setIsFcmTokenPushed(bool val) async {
    final prefs = await getSharedPreferences();

    prefs.setBool(IS_FCM_TOKEN_PUSHED, val);
    await prefs.reload();
  }

  static Future<bool> getIsLocationSaved() async {
    final prefs = await getSharedPreferences();

    return prefs.getBool(IS_LOCATION_SAVED) ?? false;
  }

  static Future<void> setIsLocationSaved(bool val) async {
    final prefs = await getSharedPreferences();

    prefs.setBool(IS_LOCATION_SAVED, val);
    await prefs.reload();
  }
}
