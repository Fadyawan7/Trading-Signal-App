import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final scheme = ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.card,
      onSurface: AppColors.text,
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
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: scheme,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.text,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card.withValues(alpha: 0.85),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.mutedText,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        prefixIconColor: AppColors.mutedText,
        suffixIconColor: AppColors.mutedText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: Color(0x5522C55E),
        selectionHandleColor: AppColors.primary,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
