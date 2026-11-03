import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color primary;
  final Color onPrimary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color sectionLabel;
  final Color icon;
  final Color border;
  final Color shadow;

  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.primary,
    required this.onPrimary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.sectionLabel,
    required this.icon,
    required this.border,
    required this.shadow,
  });

  static const light = AppPalette(
    background: Color(0xFFF6F2FA),
    surface: Colors.white,
    surfaceAlt: Color(0xFFF6F2FA),
    primary: Color(0xFF5C2483),
    onPrimary: Colors.white,
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF5B5B66),
    textTertiary: Color(0xFF8A8A96),
    sectionLabel: Color(0xFF8E7AA8),
    icon: Color(0xFF2C2C2C),
    border: Color(0xFFE0E0E0),
    shadow: Color(0x08000000),
  );

  static const dark = AppPalette(
    background: Color(0xFF121016),
    surface: Color(0xFF1E1B24),
    surfaceAlt: Color(0xFF2A2533),
    primary: Color(0xFFB98AE0),
    onPrimary: Color(0xFF2A0F40),
    textPrimary: Color(0xFFECE6F2),
    textSecondary: Color(0xFFA9A3B4),
    textTertiary: Color(0xFF857F90),
    sectionLabel: Color(0xFFB9A6D1),
    icon: Color(0xFFD9D3E2),
    border: Color(0xFF3A3445),
    shadow: Color(0x00000000),
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? primary,
    Color? onPrimary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? sectionLabel,
    Color? icon,
    Color? border,
    Color? shadow,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      sectionLabel: sectionLabel ?? this.sectionLabel,
      icon: icon ?? this.icon,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      background: l(background, other.background),
      surface: l(surface, other.surface),
      surfaceAlt: l(surfaceAlt, other.surfaceAlt),
      primary: l(primary, other.primary),
      onPrimary: l(onPrimary, other.onPrimary),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textTertiary: l(textTertiary, other.textTertiary),
      sectionLabel: l(sectionLabel, other.sectionLabel),
      icon: l(icon, other.icon),
      border: l(border, other.border),
      shadow: l(shadow, other.shadow),
    );
  }
}

extension AppPaletteX on BuildContext {
  AppPalette get colors => Theme.of(this).extension<AppPalette>()!;
}