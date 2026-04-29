import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_controller.dart';

class AppColors {
  static const emerald400 = Color(0xFF34D399);
  static const emerald500 = Color(0xFF10B981);
  static const emerald600 = Color(0xFF059669);
  static const teal400 = Color(0xFF2DD4BF);
  static const teal500 = Color(0xFF14B8A6);
  static const teal600 = Color(0xFF0D9488);

  static const amber400 = Color(0xFFFBBF24);
  static const amber500 = Color(0xFFF59E0B);
  static const yellow400 = Color(0xFFFACC15);
  static const yellow500 = Color(0xFFEAB308);

  static const primary = emerald500;
  static const accent = teal500;

  static const success = emerald500;
  static const warning = amber500;
  static const error = Color(0xFFEF4444);
  static const info = teal500;

  static const ring = emerald500;

  static const Color _lightBackground = Color(0xFFF8FAFC);
  static const Color _lightBackgroundSecondary = Color(0xFFE2E8F0);
  static const Color _lightCard = Colors.white;
  static const Color _lightPopover = Colors.white;
  static const Color _lightSurfaceGlass = Color(0xCCFFFFFF);
  static const Color _lightSurfaceGlassHover = Color(0xFFF8FAFC);
  static const Color _lightSecondary = Color(0xFFF1F5F9);
  static const Color _lightText = Color(0xFF0F172A);
  static const Color _lightTextSecondary = Color(0xFF1E293B);
  static const Color _lightMutedText = Color(0xFF64748B);
  static const Color _lightTextDisabled = Color(0xFF94A3B8);
  static const Color _lightBorder = Color(0x1F0F172A);
  static const Color _lightInput = Color(0x1F0F172A);
  static const Color _lightInputBackground = Colors.white;
  static const Color _lightSidebar = Colors.white;

  static const Color _darkBackground = Color(0xFF0A0F1E);
  static const Color _darkBackgroundSecondary = Color(0xFF111827);
  static const Color _darkCard = Color(0xFF0F172A);
  static const Color _darkPopover = Color(0xFF0F172A);
  static const Color _darkSurfaceGlass = Color(0x0DFFFFFF);
  static const Color _darkSurfaceGlassHover = Color(0x1AFFFFFF);
  static const Color _darkSecondary = Color(0x0DFFFFFF);
  static const Color _darkText = Color(0xFFFFFFFF);
  static const Color _darkTextSecondary = Color(0xFFE5E7EB);
  static const Color _darkMutedText = Color(0xFF9CA3AF);
  static const Color _darkTextDisabled = Color(0xFF6B7280);
  static const Color _darkBorder = Color(0x3310B981);
  static const Color _darkInput = Color(0x3310B981);
  static const Color _darkInputBackground = _darkCard;
  static const Color _darkSidebar = _darkCard;

  static bool get _isDark {
    if (Get.isRegistered<ThemeController>()) {
      return Get.find<ThemeController>().isDarkMode;
    }
    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }

  static Color get background => _isDark ? _darkBackground : _lightBackground;
  static Color get backgroundSecondary =>
      _isDark ? _darkBackgroundSecondary : _lightBackgroundSecondary;
  static Color get card => _isDark ? _darkCard : _lightCard;
  static Color get popover => _isDark ? _darkPopover : _lightPopover;
  static Color get surfaceGlass =>
      _isDark ? _darkSurfaceGlass : _lightSurfaceGlass;
  static Color get surfaceGlassHover =>
      _isDark ? _darkSurfaceGlassHover : _lightSurfaceGlassHover;
  static Color get secondary => _isDark ? _darkSecondary : _lightSecondary;
  static Color get text => _isDark ? _darkText : _lightText;
  static Color get textSecondary =>
      _isDark ? _darkTextSecondary : _lightTextSecondary;
  static Color get mutedText => _isDark ? _darkMutedText : _lightMutedText;
  static Color get textDisabled =>
      _isDark ? _darkTextDisabled : _lightTextDisabled;
  static Color get border => _isDark ? _darkBorder : _lightBorder;
  static Color get input => _isDark ? _darkInput : _lightInput;
  static Color get inputBackground =>
      _isDark ? _darkInputBackground : _lightInputBackground;
  static Color get sidebar => _isDark ? _darkSidebar : _lightSidebar;
}
