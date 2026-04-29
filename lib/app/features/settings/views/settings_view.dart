import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/theme_controller.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/settings_view_model.dart';

class SettingsView extends GetView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: AppColors.background,
          centerTitle: true,
          surfaceTintColor: AppColors.background,
          scrolledUnderElevation: 0,
          elevation: 0,
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 18,
              color: AppColors.text,
            ),
          ),
        ),
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            children: [
              const _SectionTitle('Appearance'),
              const SizedBox(height: 8),
              MarketPanel(
                radius: 16,
                padding: EdgeInsets.zero,
                child: _row(
                  icon: controller.isDarkTheme
                      ? Icons.dark_mode
                      : controller.isLightTheme
                      ? Icons.light_mode
                      : Icons.brightness_auto,
                  label: 'Theme',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _themeBtn(
                        icon: Icons.brightness_auto,
                        active: controller.isSystemTheme,
                        onTap: () => controller.setThemePreference(
                          AppThemePreference.system,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _themeBtn(
                        icon: Icons.light_mode,
                        active: controller.isLightTheme,
                        onTap: () => controller.setThemePreference(
                          AppThemePreference.light,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _themeBtn(
                        icon: Icons.dark_mode,
                        active: controller.isDarkTheme,
                        onTap: () => controller.setThemePreference(
                          AppThemePreference.dark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Use phone setting, or force light/dark for the whole app.',
                style: TextStyle(color: AppColors.mutedText, fontSize: 12),
              ),
              const SizedBox(height: 14),
              const _SectionTitle('Notifications'),
              const SizedBox(height: 8),
              MarketPanel(
                radius: 16,
                padding: EdgeInsets.zero,
                child: _row(
                  icon: Icons.notifications_none,
                  label: 'Push Notifications',
                  trailing: Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: controller.notifications.value,
                      onChanged: controller.setNotifications,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const _SectionTitle('General'),
              const SizedBox(height: 8),
              MarketPanel(
                radius: 16,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _row(
                      icon: Icons.shield_outlined,
                      label: 'Privacy & Security',
                      trailing: Icon(
                        Icons.chevron_right,
                        color: AppColors.mutedText,
                      ),
                    ),
                    _divider(),
                    _row(
                      icon: Icons.language,
                      label: 'Language',
                      trailing: Icon(
                        Icons.chevron_right,
                        color: AppColors.mutedText,
                      ),
                    ),
                    _divider(),
                    _row(
                      icon: Icons.help_outline,
                      label: 'Help & Support',
                      trailing: Icon(
                        Icons.chevron_right,
                        color: AppColors.mutedText,
                      ),
                    ),
                    _divider(),
                    _row(
                      icon: Icons.info_outline,
                      label: 'About',
                      trailing: Icon(
                        Icons.chevron_right,
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                      ),
                    ),
                    child: Icon(Icons.trending_up, size: 30),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'TradeConnect',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() => Divider(height: 1, color: AppColors.border);

  Widget _themeBtn({
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: active
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                )
              : null,
          color: active ? null : AppColors.secondary,
        ),
        child: Icon(
          icon,
          size: 16,
          color: active ? Colors.white : AppColors.mutedText,
        ),
      ),
    );
  }

  Widget _row({
    required IconData icon,
    required String label,
    required Widget trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.15),
                  AppColors.accent.withValues(alpha: 0.15),
                ],
              ),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        color: AppColors.mutedText,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    );
  }
}
