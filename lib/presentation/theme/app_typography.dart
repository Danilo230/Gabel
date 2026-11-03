import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_palette.dart';

class AppTypography {
  AppTypography._();
  static const String fontFamily = 'ProzaLibre';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryPurple,
    letterSpacing: -0.5,
  );
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryPurple,
  );
  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionHeader = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );

  static const TextStyle hint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.searchIcon,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle buttonSecondary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPurple,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: subtitle,
    bodyLarge: bodyRegular,
    bodyMedium: bodySecondary,
    bodySmall: caption,
    labelLarge: button,
    labelSmall: sectionHeader,
  );

  static TextTheme textThemeFor(AppPalette p) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: p.primary),
      titleLarge: titleLarge.copyWith(color: p.textPrimary),
      titleMedium: titleMedium.copyWith(color: p.primary),
      titleSmall: subtitle.copyWith(color: p.textPrimary),
      bodyLarge: bodyRegular.copyWith(color: p.textPrimary),
      bodyMedium: bodySecondary.copyWith(color: p.textSecondary),
      bodySmall: caption.copyWith(color: p.textTertiary),
      labelLarge: button.copyWith(color: p.onPrimary),
      labelSmall: sectionHeader.copyWith(color: p.textSecondary),
    );
  }
}
