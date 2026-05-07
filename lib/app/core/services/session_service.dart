import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/auth_user.dart';

class SessionService extends GetxService {
  static const _userKey = 'session_user';
  static const _roleSelectionCompletedKey = 'role_selection_completed';

  late SharedPreferences _preferences;
  final Rxn<AuthUser> currentUser = Rxn<AuthUser>();

  Future<SessionService> init() async {
    _preferences = await SharedPreferences.getInstance();
    final userJson = _preferences.getString(_userKey);
    if (userJson != null && userJson.isNotEmpty) {
      currentUser.value = AuthUser.fromJson(
        jsonDecode(userJson) as Map<String, dynamic>,
      );
    }
    return this;
  }

  bool get isLoggedIn => currentUser.value != null;

  String? get authToken => currentUser.value?.token;

  bool get hasCompletedRoleSelection =>
      _preferences.getBool(_roleSelectionCompletedKey) ?? false;

  Future<void> saveUser(AuthUser user) async {
    currentUser.value = user;
    await _preferences.setString(_userKey, jsonEncode(user.toJson()));
    await _preferences.setBool(_roleSelectionCompletedKey, false);
  }

  Future<void> completeRoleSelection() async {
    await _preferences.setBool(_roleSelectionCompletedKey, true);
  }

  Future<void> clearSession() async {
    currentUser.value = null;
    await _preferences.remove(_userKey);
    await _preferences.remove(_roleSelectionCompletedKey);
  }
}
