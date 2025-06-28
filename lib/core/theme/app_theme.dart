import 'package:flutter/material.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData _getTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color onPrimaryColor,
    required Color secondaryColor,
    required Color onSecondaryColor,
    required Color errorColor,
    required Color onErrorColor,
    required Color surfaceColor,
    required Color onSurfaceColor,
  }) {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: secondaryColor,
        onSecondary: onSecondaryColor,
        error: errorColor,
        onError: onErrorColor,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
      ),
    );
  }

  static ThemeData getLightThemeData() {
    return _getTheme(
      brightness: Brightness.light,
      primaryColor: AppColors.blue,
      onPrimaryColor: AppColors.white,
      secondaryColor: AppColors.darkBlue,
      onSecondaryColor: AppColors.white,
      errorColor: AppColors.red,
      onErrorColor: AppColors.white,
      surfaceColor: AppColors.white,
      onSurfaceColor: AppColors.blue,
    );
  }
}
