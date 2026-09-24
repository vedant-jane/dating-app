import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.plusJakartaSansTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.cardBackground,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: textTheme.copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.textDark,
          fontWeight: FontWeight.w800,
          fontSize: 32,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
          fontSize: 26,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w400,
          fontSize: 15,
          height: 1.4,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        labelLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 24,
      ),
    );
  }
}
