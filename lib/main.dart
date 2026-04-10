import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_colors.dart';
import 'app/theme/app_theme.dart';

void main() {
  runApp(const TradingGroupsApp());
}

class TradingGroupsApp extends StatelessWidget {
  const TradingGroupsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Trading Groups Marketplace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return Container(
          color: const Color(0xFF111827),
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Material(
              color: AppColors.background,
              child: MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: const TextScaler.linear(0.9),
                ),
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
    );
  }
}
