import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_palette.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData light = _build(AppPalette.light, Brightness.light);
  static final ThemeData dark = _build(AppPalette.dark, Brightness.dark);

  static ThemeData _build(AppPalette p, Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      brightness: brightness,
      fontFamily: AppTypography.fontFamily,
      textTheme: AppTypography.textThemeFor(p),
      extensions: [p],
      scaffoldBackgroundColor: isDark ? p.background : null,
      colorScheme: isDark
          ? ColorScheme.fromSeed(
              seedColor: AppColors.primaryPurple,
              brightness: Brightness.dark,
            ).copyWith(
              primary: p.primary,
              onPrimary: p.onPrimary,
              surface: p.surface,
              onSurface: p.textPrimary,
              outline: p.border,
            )
          : null,
      dividerTheme: isDark ? DividerThemeData(color: p.border) : null,
      dialogTheme: isDark ? DialogThemeData(backgroundColor: p.surface) : null,
      bottomSheetTheme:
          isDark ? BottomSheetThemeData(backgroundColor: p.surface) : null,
    );
  }
}