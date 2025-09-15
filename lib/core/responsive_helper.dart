import 'package:flutter/material.dart';

/// Classe responsável por definir breakpoints e dimensões responsivas
/// para diferentes tamanhos de dispositivos móveis
class ResponsiveHelper {
  static const double _smallPhoneWidth = 320; // iPhone SE, Galaxy S4
  static const double _mediumPhoneWidth = 375; // iPhone 8, X
  static const double _largePhoneWidth = 414; // iPhone Plus, Galaxy S8+
  static const double _extraLargePhoneWidth = 480; // Grandes Android

  /// Retorna o tipo de dispositivo baseado na largura da tela
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < _smallPhoneWidth) {
      return DeviceType.extraSmall;
    } else if (width < _mediumPhoneWidth) {
      return DeviceType.small;
    } else if (width < _largePhoneWidth) {
      return DeviceType.medium;
    } else if (width < _extraLargePhoneWidth) {
      return DeviceType.large;
    } else {
      return DeviceType.extraLarge;
    }
  }

  /// Retorna padding responsivo baseado no tipo de dispositivo
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.extraSmall:
        return const EdgeInsets.all(8.0);
      case DeviceType.small:
        return const EdgeInsets.all(12.0);
      case DeviceType.medium:
        return const EdgeInsets.all(16.0);
      case DeviceType.large:
        return const EdgeInsets.all(20.0);
      case DeviceType.extraLarge:
        return const EdgeInsets.all(24.0);
    }
  }

  /// Retorna espaçamento responsivo entre elementos
  static double getResponsiveSpacing(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.extraSmall:
        return 4.0;
      case DeviceType.small:
        return 6.0;
      case DeviceType.medium:
        return 8.0;
      case DeviceType.large:
        return 10.0;
      case DeviceType.extraLarge:
        return 12.0;
    }
  }

  /// Retorna altura do card responsiva
  static double getCardHeight(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.extraSmall:
        return 100.0;
      case DeviceType.small:
        return 110.0;
      case DeviceType.medium:
        return 120.0;
      case DeviceType.large:
        return 130.0;
      case DeviceType.extraLarge:
        return 140.0;
    }
  }

  /// Retorna tamanho da fonte responsivo
  static double getResponsiveFontSize(
    BuildContext context,
    ResponsiveFontSize size,
  ) {
    final deviceType = getDeviceType(context);

    switch (size) {
      case ResponsiveFontSize.small:
        return _getSmallFontSize(deviceType);
      case ResponsiveFontSize.medium:
        return _getMediumFontSize(deviceType);
      case ResponsiveFontSize.large:
        return _getLargeFontSize(deviceType);
      case ResponsiveFontSize.extraLarge:
        return _getExtraLargeFontSize(deviceType);
    }
  }

  static double _getSmallFontSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.extraSmall:
        return 10.0;
      case DeviceType.small:
        return 12.0;
      case DeviceType.medium:
        return 14.0;
      case DeviceType.large:
        return 16.0;
      case DeviceType.extraLarge:
        return 18.0;
    }
  }

  static double _getMediumFontSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.extraSmall:
        return 12.0;
      case DeviceType.small:
        return 14.0;
      case DeviceType.medium:
        return 16.0;
      case DeviceType.large:
        return 18.0;
      case DeviceType.extraLarge:
        return 20.0;
    }
  }

  static double _getLargeFontSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.extraSmall:
        return 16.0;
      case DeviceType.small:
        return 18.0;
      case DeviceType.medium:
        return 20.0;
      case DeviceType.large:
        return 22.0;
      case DeviceType.extraLarge:
        return 24.0;
    }
  }

  static double _getExtraLargeFontSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.extraSmall:
        return 20.0;
      case DeviceType.small:
        return 22.0;
      case DeviceType.medium:
        return 24.0;
      case DeviceType.large:
        return 28.0;
      case DeviceType.extraLarge:
        return 32.0;
    }
  }

  /// Retorna altura da AppBar responsiva
  static double getAppBarHeight(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.extraSmall:
        return 50.0;
      case DeviceType.small:
        return 56.0;
      case DeviceType.medium:
        return 60.0;
      case DeviceType.large:
        return 64.0;
      case DeviceType.extraLarge:
        return 68.0;
    }
  }

  /// Retorna número de colunas para grid layouts
  static int getGridColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 350) {
      return 1; // Extra small: uma coluna
    } else if (width < 600) {
      return 2; // Small/Medium: duas colunas
    } else {
      return 3; // Large: três colunas
    }
  }

  /// Retorna se a tela é considerada pequena
  static bool isSmallScreen(BuildContext context) {
    return getDeviceType(context) == DeviceType.extraSmall ||
        getDeviceType(context) == DeviceType.small;
  }
}

/// Tipos de dispositivos baseados na largura
enum DeviceType {
  extraSmall, // < 320px
  small, // 320px - 375px
  medium, // 375px - 414px
  large, // 414px - 480px
  extraLarge, // > 480px
}

/// Tamanhos de fonte responsivos
enum ResponsiveFontSize {
  small,
  medium,
  large,
  extraLarge,
}
