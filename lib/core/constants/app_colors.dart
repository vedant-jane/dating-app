import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette
  static const Color primary = Color(0xFFE93E63);
  static const Color primaryDark = Color(0xFFD62B52);
  static const Color primaryLight = Color(0xFFFF527B);
  static const Color primarySoft = Color(0xFFFFF0F3);
  static const Color primaryBorder = Color(0xFFFFD4DE);

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFFFBF9F6);
  static const Color cardBackground = Colors.white;
  static const Color surfaceMuted = Color(0xFFF4F2EE);
  static const Color surfaceLight = Color(0xFFFAF7F3);

  // Text
  static const Color textPrimary = Color(0xFF1E1E22);
  static const Color textSecondary = Color(0xFF75757C);
  static const Color textMuted = Color(0xFFA0A0A7);
  static const Color textDark = Color(0xFF111113);

  // Accents & Badges
  static const Color onlineGreen = Color(0xFF22C55E);
  static const Color likeGreen = Color(0xFF10B981);
  static const Color nopeRed = Color(0xFFEF4444);
  static const Color goldCoin = Color(0xFFF59E0B);
  static const Color verifiedBlue = Color(0xFF3B82F6);
  static const Color roseRed = Color(0xFFE11D48);

  // Glass / Overlays
  static const Color darkOverlay = Color(0x73000000);
  static const Color cardPill = Color(0x6618181B);
  static const Color divider = Color(0xFFEBE8E3);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF4D75), Color(0xFFE82E5A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardOverlayGradient = LinearGradient(
    colors: [
      Colors.transparent,
      Color(0x33000000),
      Color(0x99000000),
      Color(0xE6000000),
    ],
    stops: [0.3, 0.55, 0.75, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient datingGoalGradient = LinearGradient(
    colors: [Color(0xFFE83A64), Color(0xFFD92854)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
