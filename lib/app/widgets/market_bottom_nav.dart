import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../theme/app_colors.dart';

class MarketBottomNav extends StatelessWidget {
  const MarketBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navGradientColors = isDark
        ? const [Color(0xCC111827), Color(0x990A0F1E)]
        : [
            Colors.white.withValues(alpha: 0.7),
            const Color(0xFFF8FAFC).withValues(alpha: 0.6),
          ];
    final navBorderColor = isDark
        ? AppColors.primary.withValues(alpha: 0.45)
        : AppColors.border;
    final activeBubbleColor = isDark
        ? Colors.white.withValues(alpha: 0.14)
        : AppColors.primary.withValues(alpha: 0.12);
    final inactiveItemColor = isDark
        ? Colors.white.withValues(alpha: 0.5)
        : AppColors.mutedText;

    final items = const [
      _NavItem(route: AppRoutes.home, icon: Icons.home_outlined, label: 'Home'),
      _NavItem(route: AppRoutes.explore, icon: Icons.search, label: 'Explore'),
      _NavItem(
        route: AppRoutes.chats,
        icon: Icons.chat_bubble_outline,
        label: 'Chats',
      ),
      _NavItem(
        route: AppRoutes.profile,
        icon: Icons.person_outline,
        label: 'Profile',
      ),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: navGradientColors,
                ),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: navBorderColor, width: 0.8),
              ),
            child: Row(
              children: List.generate(items.length, (index) {
                final item = items[index];
                final active = index == currentIndex;
                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      if (currentIndex == index) return;
                      Get.offAllNamed(item.route);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOutCubic,

                      //  padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 240),
                            curve: Curves.easeOut,
                            width: active ? 30 : 22,
                            height: active ? 30 : 22,
                            decoration: BoxDecoration(
                              color: active
                                  ? activeBubbleColor
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item.icon,
                              size: active ? 18 : 20,
                              color: active
                                  ? AppColors.primary
                                  : inactiveItemColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11,
                              color: active
                                  ? AppColors.primary
                                  : inactiveItemColor,
                              fontWeight: active
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    ));
  }
}

class _NavItem {
  const _NavItem({
    required this.route,
    required this.icon,
    required this.label,
  });

  final String route;
  final IconData icon;
  final String label;
}
