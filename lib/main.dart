import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_colors.dart';
import 'app/theme/app_theme.dart';
import 'app/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => ThemeController().init());
  runApp(const TradingGroupsApp());
}

class TradingGroupsApp extends StatelessWidget {
  const TradingGroupsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        title: 'Trading Groups Marketplace',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        initialRoute: AppRoutes.login,
        getPages: AppPages.pages,
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return Container(
            color: AppColors.backgroundSecondary,
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Material(
                color: AppColors.background,
                child: MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: const TextScaler.linear(0.9),
                  ),
                  child: KeyedSubtree(
                    key: ValueKey(
                      '${themeController.preference.name}-${themeController.isDarkMode}',
                    ),
                    child: child ?? const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
