import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static final PrefUtils _instance = PrefUtils._internal();

  factory PrefUtils() {
    return _instance;
  }

  PrefUtils._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  String getString(String key) {
    return _prefs?.getString(key) ?? "";
  }

  Future<bool> setString(String key, String value) {
    return _prefs?.setString(key, value) ?? Future.value(false);
  }

  int getInt(String key, int value) {
    return _prefs?.getInt(key) ?? 0;
  }

  Future<bool> setInt(String key, String value) {
    return _prefs?.setString(key, value) ?? Future.value(false);
  }

  bool getBool(String key, bool value) {
    return _prefs?.getBool(key) ?? false;
  }

  Future<bool> setBool(String key, bool value) {
    return _prefs?.setBool(key, value) ?? Future.value(false);
  }

  /// Keys for shared preferences
  String get authToken => "authToken";

  String get refreshToken => "refreshToken";

  String get userLoggedIn => "userLoggedIn";

  String get email => "email";
  String get macAddress => "deviceUDID";

  /// Storing Key Values

  String getAuthToken() {
    return getString(authToken);
  }

  saveAuthToken(String? token) {
    _prefs!.setString(authToken, token!);
  }

  String getRefreshToken() {
    return getString(refreshToken);
  }

  saveRefreshToken(String? token) {
    _prefs!.setString(refreshToken, token!);
  }

  Future<bool> saveUserLoggedIn(bool value) {
    return setBool(userLoggedIn, value);
  }

  bool getUserLoggedIn() {
    return getBool(userLoggedIn, false);
  }

  String getUserEmail() {
    return getString(email);
  }

  saveUserEmail(String emailId) {
    _prefs!.setString(email, emailId);
  }

  String getMacAddress() {
    return getString(macAddress);
  }

  saveMacAddress(String uuid) {
    _prefs!.setString(macAddress, uuid);
  }
}
