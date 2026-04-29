import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/app_constants.dart';
import '../theme/app_colors.dart';
import 'market_bottom_nav.dart';

class MarketScaffold extends StatelessWidget {
  const MarketScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBack = false,
    this.showBottomNav = false,
    this.currentBottomNavIndex = 0,
    this.actions,
  });

  final String title;
  final Widget body;
  final bool showBack;
  final bool showBottomNav;
  final int currentBottomNavIndex;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
        leading: showBack
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              )
            : null,
        actions: actions,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.mobileFrameWidth,
          ),
          child: body,
        ),
      ),
      bottomNavigationBar: showBottomNav
          ? MarketBottomNav(currentIndex: currentBottomNavIndex)
          : null,
      backgroundColor: AppColors.background,
    );
  }
}
