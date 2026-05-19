import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/session_service.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_loading_overlay.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../viewmodel/user_profile_view_model.dart';

class UserProfileView extends GetView<UserProfileViewModel> {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        message: controller.loadingMessage.value,
        child: Scaffold(
          backgroundColor: AppColors.background,
          extendBody: true,
          bottomNavigationBar: const MarketBottomNav(currentIndex: 4),
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.backgroundSecondary,
                        AppColors.background,
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    const _Header(),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => controller.getProfile(showLoading: false),
                        color: AppColors.primary,
                        backgroundColor: AppColors.card,
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
                          children: [
                            const _ProfileCard(),
                            const SizedBox(height: 16),
                            const _RoleSwitchSection(),
                            const SizedBox(height: 16),
                            const _MyGroupsSection(),
                            const SizedBox(height: 24),
                            const _QuickActionsSection(),
                            const SizedBox(height: 24),
                            const _SettingsSection(),
                            const SizedBox(height: 24),
                            const _LogoutButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 42), // Spacer for centering
          Text(
            'Profile',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(AppRoutes.settings),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(
                Icons.settings_outlined,
                color: AppColors.text,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends GetView<UserProfileViewModel> {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionService>();
    return Obx(
      () {
        final user = session.user;
        final initials =
            user != null && user.name.isNotEmpty
                ? user.name
                    .trim()
                    .split(' ')
                    .map((e) => e[0])
                    .take(2)
                    .join()
                    .toUpperCase()
                : '??';

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundSecondary,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Center(
                          child: Text(
                            user?.avatar != null && user!.avatar!.isNotEmpty
                                ? user.avatar!
                                : initials,
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: user?.avatar != null ? 40 : 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () => Get.toNamed(AppRoutes.editProfile),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.backgroundSecondary,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.buttonText,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'Loading...',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? '',
                          style: TextStyle(
                            color: AppColors.mutedText,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: AppColors.primary,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                user?.roles
                                        .map((e) => e.displayName)
                                        .join(', ') ??
                                    'User Member',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: _MetricItem(value: '3', label: 'Groups')),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: _MetricItem(
                      value: '+47%',
                      label: 'ROI',
                      isHighlight: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(child: _MetricItem(value: '156', label: 'Signals')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isHighlight;

  const _MetricItem({
    required this.value,
    required this.label,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: isHighlight ? AppColors.primary : AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: AppColors.mutedText, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _MyGroupsSection extends StatelessWidget {
  const _MyGroupsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Groups',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.explore),
              child: Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: AppColors.primary, size: 14),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const _GroupItem(
          name: 'Crypto Elite Signals',
          date: 'Joined Jan 2026',
          icon: Icons.rocket_launch_rounded,
        ),
        const _GroupItem(
          name: 'Forex Masters Club',
          date: 'Joined Feb 2026',
          icon: Icons.payments_rounded,
        ),
        const _GroupItem(
          name: 'Gold Trading Pro',
          date: 'Joined Mar 2026',
          icon: Icons.emoji_events_rounded,
        ),
      ],
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionService>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Obx(() {
          final isTrader = session.isTrader;
          final isApplied = session.rxTraderStatus.value == 'applied';

          if (isTrader) {
            return Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    title: 'Explore Groups',
                    icon: Icons.groups_outlined,
                    onTap: () => Get.toNamed(AppRoutes.explore),
                  ),
                ),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _ActionCard(
                  title: 'Explore Groups',
                  icon: Icons.groups_outlined,
                  onTap: () => Get.toNamed(AppRoutes.explore),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ActionCard(
                  title: isApplied ? 'Pending Review' : 'Become Trader',
                  icon: Icons.trending_up_rounded,
                  hasNotification: isApplied,
                  onTap: () {
                    if (isApplied) {
                      Get.defaultDialog(
                        title: 'Application Under Review',
                        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        backgroundColor: const Color(0xFF1E293B),
                        contentPadding: const EdgeInsets.all(20),
                        middleText: 'Your trader application has been submitted successfully and is currently under review by our admin team. We will notify you once your application has been approved!',
                        middleTextStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        textConfirm: 'Okay',
                        confirmTextColor: Colors.white,
                        buttonColor: const Color(0xFF14B8A6),
                        onConfirm: () => Get.back(),
                      );
                    } else {
                      Get.toNamed(AppRoutes.applyTrader);
                    }
                  },
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool hasNotification;

  const _ActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
    this.hasNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(icon, color: AppColors.text, size: 28),
                ),
                if (hasNotification)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.card, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Settings',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              const _SettingItem(
                icon: Icons.notifications_none_rounded,
                label: 'Notifications',
              ),
              const _SettingItem(icon: Icons.security_rounded, label: 'Security'),
              const _SettingItem(
                icon: Icons.help_outline_rounded,
                label: 'Help & Support',
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLast;

  const _SettingItem({
    required this.icon,
    required this.label,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.settings),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.mutedText, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: AppColors.text, fontSize: 15),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.mutedText, size: 20),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends GetView<UserProfileViewModel> {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.logout,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: Colors.red, size: 20),
            SizedBox(width: 12),
            Text(
              'Logout Account',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupItem extends StatelessWidget {
  final String name;
  final String date;
  final IconData icon;

  const _GroupItem({
    required this.name,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.groupChat),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      date,
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF14B8A6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleSwitchSection extends StatelessWidget {
  const _RoleSwitchSection();

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionService>();
    return Obx(() {
      if (!session.isTrader || !session.isUser) {
        return const SizedBox.shrink();
      }
      final isTraderActive = session.isActiveRoleTrader;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active View Mode',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isTraderActive ? 'Viewing as Trader Perspective' : 'Viewing as User Perspective',
                    style: TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              activeColor: AppColors.primary,
              value: isTraderActive,
              onChanged: (val) async {
                final newRole = val ? 'trader' : 'user';
                await session.setActiveRole(newRole);
                Get.snackbar(
                  'Role Switched',
                  'Switched to ${newRole.capitalizeFirst} perspective successfully!',
                  backgroundColor: const Color(0xFF1E293B),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 2),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
