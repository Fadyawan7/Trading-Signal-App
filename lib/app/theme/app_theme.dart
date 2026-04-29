import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final scheme = ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: Colors.white,
      onSurface: const Color(0xFF0F172A),
      outline: const Color(0x4010B981),
      error: AppColors.error,
    );

    final textTheme =
        GoogleFonts.plusJakartaSansTextTheme(
          ThemeData.light().textTheme,
        ).copyWith(
          bodyLarge: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            height: 1.4,
            color: const Color(0xFF0F172A),
          ),
          bodyMedium: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            height: 1.4,
            color: const Color(0xFF1E293B),
          ),
          bodySmall: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            height: 1.35,
            color: const Color(0xFF475569),
          ),
          titleLarge: GoogleFonts.sora(
            fontSize: 18,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
          titleMedium: GoogleFonts.sora(
            fontSize: 16,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
          titleSmall: GoogleFonts.sora(
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      colorScheme: scheme,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF0F172A),
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: const Color(0xFF475569),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        prefixIconColor: const Color(0xFF475569),
        suffixIconColor: const Color(0xFF475569),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0x4010B981)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0x4010B981)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.emerald500, width: 1.4),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: Color(0x5510B981),
        selectionHandleColor: AppColors.primary,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData get darkTheme {
    final scheme = ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: const Color(0xFF0F172A),
      onSurface: Colors.white,
      outline: const Color(0x3310B981),
      error: AppColors.error,
    );

    final textTheme =
        GoogleFonts.plusJakartaSansTextTheme(
          ThemeData.dark().textTheme,
        ).copyWith(
          bodyLarge: GoogleFonts.plusJakartaSans(fontSize: 15, height: 1.4),
          bodyMedium: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.4),
          bodySmall: GoogleFonts.plusJakartaSans(fontSize: 12, height: 1.35),
          titleLarge: GoogleFonts.sora(
            fontSize: 18,
            height: 1.3,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: GoogleFonts.sora(
            fontSize: 16,
            height: 1.3,
            fontWeight: FontWeight.w700,
          ),
          titleSmall: GoogleFonts.sora(
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w700,
          ),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A0F1E),
      colorScheme: scheme,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0F172A),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: const Color(0xFF9CA3AF),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        prefixIconColor: const Color(0xFF9CA3AF),
        suffixIconColor: const Color(0xFF9CA3AF),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0x3310B981)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0x3310B981)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.emerald500, width: 1.4),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: Color(0x5510B981),
        selectionHandleColor: AppColors.primary,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
