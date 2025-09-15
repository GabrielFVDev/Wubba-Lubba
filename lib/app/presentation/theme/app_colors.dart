import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryBackground = Color(0xFF0D1421);
  static const Color primaryBackgroundAlpha = Color(
    0xCC0D1421,
  ); // primaryBackground com alpha 204
  static const Color secondaryBackground = Color(0xFF1A2332);

  static const Color textPrimary = Colors.white;

  static const Color statusAlive = Colors.green;
  static const Color statusDead = Colors.red;
  static const Color statusUnknown = Colors.orange;

  static const Color accentSecondary = Color(0xFF4CAF50);
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;

  static const Color greenNeon = Color(0xFF00D4AA);
  static const Color greyishGreen = Color(0xFF008B8B);
  static const Color blackGreen = Color(0xFF004D4D);
  static const Color purple = Color(0xffB34DB2);

  static const Color particleGold = Color(0xFFFFD700);
  static const Color particleBlue = Color(0xFF4169E1);

  static const Color cardBackground = Color(0x0DFFFFFF);
  static const Color cardBorder = Color(0x01FFFFFF);
  static const Color searchBackground = Color(0x0FFFFFFF);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      primaryBackgroundAlpha,
      primaryBackground,
    ],
  );

  static const RadialGradient portalGradient = RadialGradient(
    colors: [
      greenNeon,
      greyishGreen,
      blackGreen,
    ],
  );
}
