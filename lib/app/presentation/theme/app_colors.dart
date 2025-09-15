import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryBackground = Color(0xFF0D1421);
  static const Color secondaryBackground = Color(0xFF1A2332);

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textHint = Color(0xFF78909C);

  static const Color statusAlive = Colors.green;
  static const Color statusDead = Colors.red;
  static const Color statusUnknown = Colors.orange;

  static const Color accentSecondary = Color(0xFF4CAF50);
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;

  static const Color cardBackground = Color(0x0DFFFFFF);
  static const Color cardBorder = Color(0x01FFFFFF);
  static const Color searchBackground = Color(0x0FFFFFFF);

  static const Color overlay = Color(0x80000000);
  static const Color shadow = Color(0x54000000);

  static const Color iconPrimary = Color(0xB3FFFFFF);
  static const Color iconSecondary = Color(0x80FFFFFF);
  static const Color iconDisabled = Color(0x54FFFFFF);

  static const Color buttonPrimary = Colors.green;
  static const Color buttonSecondary = Color(0xFF37474F);
  static const Color buttonDisabled = Color(0xFF78909C);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xCC0D1421),
      primaryBackground,
    ],
  );

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return statusAlive;
      case 'dead':
        return statusDead;
      default:
        return statusUnknown;
    }
  }

  static Color getStatusColorWithOpacity(String status, double opacity) {
    return getStatusColor(status).withValues(alpha: opacity);
  }
}
