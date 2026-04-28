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
      top: false,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xF0111827), Color(0xD90A0F1E)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              border: const Border(
                top: BorderSide(color: AppColors.primary, width: 0.4),
                left: BorderSide(color: AppColors.primary, width: 0.4),
                right: BorderSide(color: AppColors.primary, width: 0.4),
                bottom: BorderSide.none, // ❌ no bottom border
              ),
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
                      Get.offNamed(item.route);
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
                                  ? Colors.white.withValues(alpha: 0.14)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item.icon,
                              size: active ? 18 : 20,
                              color: active
                                  ? AppColors.primary
                                  : Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11,
                              color: active
                                  ? AppColors.primary
                                  : Colors.white.withValues(alpha: 0.5),
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
    );
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
