import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_controller.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/user_profile_view_model.dart';

class UserProfileView extends GetView<UserProfileViewModel> {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const menu = [
      {'icon': Icons.notifications_none, 'label': 'Notifications'},
      {'icon': Icons.shield_outlined, 'label': 'Privacy & Security'},
      {'icon': Icons.help_outline, 'label': 'Help & Support'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    return Obx(() {
      final themePreference = Get.find<ThemeController>().preference;

      return Scaffold(
        key: ValueKey('user-profile-${themePreference.name}'),
        backgroundColor: AppColors.background,
        bottomNavigationBar: const MarketBottomNav(currentIndex: 3),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MarketPanel(
                radius: 18,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  colors: [AppColors.primary, AppColors.accent],
                                ),
                              ),
                              child: Text('👤', style: TextStyle(fontSize: 34)),
                            ),
                            Positioned(
                              right: -2,
                              bottom: -2,
                              child: InkWell(
                                onTap: () => Get.toNamed(AppRoutes.editProfile),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.accent,
                                      ],
                                    ),
                                  ),
                                  child: Icon(Icons.edit, size: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alex Smith',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'alex.smith@email.com',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.mutedText,
                                ),
                              ),
                              SizedBox(height: 8),
                              _Tag(icon: Icons.people, text: 'User Member'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _Metric(label: 'Groups', value: '3'),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _Metric(
                            label: 'ROI',
                            value: '+47%',
                            green: true,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _Metric(
                            label: 'Signals',
                            value: '156',
                            primary: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('My Groups', style: TextStyle(fontWeight: FontWeight.w600)),
              //     InkWell(onTap: () => Get.toNamed(AppRoutes.explore), child: Text('View All →', style: TextStyle(fontSize: 12, color: AppColors.primary))),
              //   ],
              // ),
              // const SizedBox(height: 8),
              // ...groups.map((g) => Padding(
              //       padding: const EdgeInsets.only(bottom: 8),
              //       child: InkWell(
              //         onTap: () => Get.toNamed(AppRoutes.groupChat, arguments: {'groupId': g['id']}),
              //         child: MarketPanel(
              //           radius: 14,
              //           padding: const EdgeInsets.all(12),
              //           child: Row(
              //             children: [
              //               Container(
              //                 width: 46,
              //                 height: 46,
              //                 alignment: Alignment.center,
              //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent])),
              //                 child: Text(g['avatar']! as String, style: TextStyle(fontSize: 22)),
              //               ),
              //               const SizedBox(width: 10),
              //               Expanded(
              //                 child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //                   Text(g['name']! as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              //                   Text('Joined ${g['joined']}', style: TextStyle(fontSize: 11, color: AppColors.mutedText)),
              //                 ]),
              //               ),
              //               Container(
              //                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //                 decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              //                 child: Text('Active', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.w600)),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     )),
              const SizedBox(height: 12),
              Text(
                'Quick Actions',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.people,
                      label: 'Explore Groups',
                      onTap: () => Get.toNamed(AppRoutes.explore),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.trending_up,
                      label: 'Become Trader',
                      onTap: () => Get.toNamed(AppRoutes.applyTrader),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Account Settings',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              MarketPanel(
                radius: 14,
                padding: EdgeInsets.zero,
                child: Column(
                  children: menu
                      .map(
                        (m) => InkWell(
                          onTap: () => Get.toNamed(AppRoutes.settings),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: AppColors.border),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(m['icon']! as IconData, size: 18),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    m['label']! as String,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: AppColors.mutedText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () => Get.offAllNamed(AppRoutes.login),
                child: MarketPanel(
                  radius: 14,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    this.green = false,
    this.primary = false,
  });
  final String label;
  final String value;
  final bool green;
  final bool primary;
  @override
  Widget build(BuildContext context) {
    final color = green
        ? Colors.green
        : (primary ? AppColors.primary : Colors.white);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: green
            ? Colors.green.withValues(alpha: 0.1)
            : primary
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: AppColors.mutedText, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MarketPanel(
        radius: 12,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ),
              ),
              child: Icon(icon),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
