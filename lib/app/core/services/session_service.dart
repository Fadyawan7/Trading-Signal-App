import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/auth_user.dart';

class SessionService extends GetxService {
  static const _userKey = 'session_user';
  static const _roleSelectionCompletedKey = 'role_selection_completed';
  static const _rolesKey = 'user_roles';
  static const _traderStatusKey = 'trader_status';
  static const _isSubscriptionKey = 'is_subscription';
  static const _activeRoleKey = 'active_role';

  late SharedPreferences _preferences;
  final Rxn<AuthUser> currentUser = Rxn<AuthUser>();

  final rxRoles = <String>[].obs;
  final rxTraderStatus = 'pending'.obs;
  final rxIsSubscription = false.obs;
  final rxActiveRole = 'user'.obs;

  bool get isTrader => rxRoles.contains('trader');
  bool get isUser => rxRoles.contains('user');
  bool get isActiveRoleTrader => rxActiveRole.value == 'trader';

  AuthUser? get user => currentUser.value;

  Future<SessionService> init() async {
    _preferences = await SharedPreferences.getInstance();
    final userJson = _preferences.getString(_userKey);
    if (userJson != null && userJson.isNotEmpty) {
      currentUser.value = AuthUser.fromJson(
        jsonDecode(userJson) as Map<String, dynamic>,
      );
    }
    
    final rolesList = _preferences.getStringList(_rolesKey) ?? ['user'];
    rxRoles.assignAll(rolesList);
    rxTraderStatus.value = _preferences.getString(_traderStatusKey) ?? 'pending';
    rxIsSubscription.value = _preferences.getBool(_isSubscriptionKey) ?? false;
    rxActiveRole.value = _preferences.getString(_activeRoleKey) ?? 'user';
    
    return this;
  }

  bool get isLoggedIn => currentUser.value != null;

  String? get authToken => currentUser.value?.token;

  bool get hasCompletedRoleSelection =>
      _preferences.getBool(_roleSelectionCompletedKey) ?? false;

  Future<void> saveUser(AuthUser user) async {
    currentUser.value = user;
    await _preferences.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> saveRolesData({
    required List<String> roles,
    required String traderStatus,
    required bool isSubscription,
  }) async {
    rxRoles.assignAll(roles);
    rxTraderStatus.value = traderStatus;
    rxIsSubscription.value = isSubscription;
    
    await _preferences.setStringList(_rolesKey, roles);
    await _preferences.setString(_traderStatusKey, traderStatus);
    await _preferences.setBool(_isSubscriptionKey, isSubscription);

    if (!roles.contains(rxActiveRole.value)) {
      await setActiveRole('user');
    }
  }

  Future<void> setActiveRole(String role) async {
    rxActiveRole.value = role;
    await _preferences.setString(_activeRoleKey, role);
  }

  Future<void> updateUser(AuthUser user) async {
    final currentToken = currentUser.value?.token;
    final updatedUser = AuthUser.fromJson({
      ...user.toJson(),
      if (currentToken != null && (user.token.isEmpty)) 'token': currentToken,
    });
    await saveUser(updatedUser);
  }

  Future<void> completeRoleSelection() async {
    await _preferences.setBool(_roleSelectionCompletedKey, true);
  }

  Future<void> clearSession() async {
    currentUser.value = null;
    rxRoles.assignAll(['user']);
    rxTraderStatus.value = 'pending';
    rxIsSubscription.value = false;
    rxActiveRole.value = 'user';

    await _preferences.remove(_userKey);
    await _preferences.remove(_roleSelectionCompletedKey);
    await _preferences.remove(_rolesKey);
    await _preferences.remove(_traderStatusKey);
    await _preferences.remove(_isSubscriptionKey);
    await _preferences.remove(_activeRoleKey);
  }
}
