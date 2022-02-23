import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:lu_ahatting_application/models/user_model.dart';

class UserSimplePreferences {
  static const _keyUser = 'user';
  static const myUser = User1(
    imagePath: 'assets/images/images.jpeg',
  );
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;
  static const _keyUsername = 'username';
  static const _keyLine = 'StatusLine';
  static const _keyBatch = 'Batch';
  static const _keySection = 'Section';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static getUsername() => _preferences.getString(_keyUsername);

  static Future setLine(String statusline) async =>
      await _preferences.setString(_keyLine, statusline);

  static getLine() => _preferences.getString(_keyLine);

  static Future setBatch(String batch) async =>
      await _preferences.setString(_keyBatch, batch);

  static getBatch() => _preferences.getString(_keyBatch);

  static Future setSection(String section) async =>
      await _preferences.setString(_keySection, section);

  static getSection() => _preferences.getString(_keySection);

  static Future setUser(User1 user1) async {
    final json = jsonEncode(user1.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User1 getUser1() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User1.fromJson(jsonDecode(json));
  }
}
