import '../../../core/base/base_view_model.dart';
import '../../../theme/theme_controller.dart';
import 'package:get/get.dart';

class SettingsViewModel extends BaseViewModel {
  final title = 'Settings';
  final subtitle = 'Manage preferences, notifications, and security.';
  final cta = 'Save Changes';

  final notifications = true.obs;

  ThemeController get _themeController => Get.find<ThemeController>();

  AppThemePreference get themePreference => _themeController.preference;

  bool get isSystemTheme => themePreference == AppThemePreference.system;
  bool get isLightTheme => themePreference == AppThemePreference.light;
  bool get isDarkTheme => themePreference == AppThemePreference.dark;

  Future<void> setThemePreference(AppThemePreference preference) {
    return _themeController.setPreference(preference);
  }

  void setNotifications(bool value) {
    notifications.value = value;
  }
}
