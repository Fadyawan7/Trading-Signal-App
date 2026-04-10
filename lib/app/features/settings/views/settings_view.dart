import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/settings_view_model.dart';

class SettingsView extends GetView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsBody();
  }
}

class _SettingsBody extends StatefulWidget {
  const _SettingsBody();

  @override
  State<_SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<_SettingsBody> {
  bool dark = true;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Settings',),
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
                icon: dark ? Icons.dark_mode : Icons.light_mode,
                label: 'Theme',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _themeBtn(icon: Icons.dark_mode, active: dark, onTap: () => setState(() => dark = true)),
                    const SizedBox(width: 8),
                    _themeBtn(icon: Icons.light_mode, active: !dark, onTap: () => setState(() => dark = false)),
                  ],
                ),
              ),
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
                  child: Switch(value: notifications, onChanged: (v) => setState(() => notifications = v))),
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
                  _row(icon: Icons.shield_outlined, label: 'Privacy & Security', trailing: const Icon(Icons.chevron_right, color: AppColors.mutedText)),
                  _divider(),
                  _row(icon: Icons.language, label: 'Language', trailing: const Icon(Icons.chevron_right, color: AppColors.mutedText)),
                  _divider(),
                  _row(icon: Icons.help_outline, label: 'Help & Support', trailing: const Icon(Icons.chevron_right, color: AppColors.mutedText)),
                  _divider(),
                  _row(icon: Icons.info_outline, label: 'About', trailing: const Icon(Icons.chevron_right, color: AppColors.mutedText)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent])),
                  child: const Icon(Icons.trending_up, size: 30),
                ),
                const SizedBox(height: 8),
                const Text('TradeConnect', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                const Text('Version 1.0.0', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, color: AppColors.border);

  Widget _themeBtn({required IconData icon, required bool active, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: active ? const LinearGradient(colors: [AppColors.primary, AppColors.accent]) : null,
          color: active ? null : AppColors.secondary,
        ),
        child: Icon(icon, size: 16, color: active ? Colors.white : AppColors.mutedText),
      ),
    );
  }

  Widget _row({required IconData icon, required String label, required Widget trailing}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.15), AppColors.accent.withValues(alpha: 0.15)]),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
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
    return Text(title.toUpperCase(), style: const TextStyle(fontSize: 12, color: AppColors.mutedText, fontWeight: FontWeight.w700, letterSpacing: 0.6));
  }
}
