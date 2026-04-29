import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemePreference { system, light, dark }

class ThemeController extends GetxService {
  static const _storageKey = 'app_theme_preference';

  final Rx<AppThemePreference> _preference = AppThemePreference.system.obs;

  ThemeMode get themeMode => _mapPreferenceToThemeMode(_preference.value);
  AppThemePreference get preference => _preference.value;

  bool get isDarkMode {
    switch (_preference.value) {
      case AppThemePreference.light:
        return false;
      case AppThemePreference.dark:
        return true;
      case AppThemePreference.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    }
  }

  Future<ThemeController> init() async {
    final prefs = await SharedPreferences.getInstance();
    _preference.value = _mapStringToPreference(prefs.getString(_storageKey));
    return this;
  }

  Future<void> setPreference(AppThemePreference preference) async {
    if (_preference.value == preference) {
      return;
    }

    _preference.value = preference;
    Get.changeThemeMode(themeMode);
    Get.appUpdate();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, preference.name);
  }

  ThemeMode _mapPreferenceToThemeMode(AppThemePreference preference) {
    switch (preference) {
      case AppThemePreference.light:
        return ThemeMode.light;
      case AppThemePreference.dark:
        return ThemeMode.dark;
      case AppThemePreference.system:
        return ThemeMode.system;
    }
  }

  AppThemePreference _mapStringToPreference(String? rawValue) {
    return AppThemePreference.values.firstWhere(
      (value) => value.name == rawValue,
      orElse: () => AppThemePreference.system,
    );
  }
}
