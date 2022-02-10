import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;
  static const _keyUsername = 'username';
  static const _keyLine = 'StatusLine';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static getUsername() => _preferences.getString(_keyUsername);

  static Future setLine(String statusline) async =>
      await _preferences.setString(_keyLine, statusline);

  static getLine() => _preferences.getString(_keyLine);
}
