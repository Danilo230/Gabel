import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Clase global para centralizar y estandarizar la tipografía en la aplicación Gabel.
///
/// Permite reutilizar estilos de texto individuales (AppTypography.titleLarge, etc.)
/// o configurar un tema de texto global (AppTypography.textTheme) en el ThemeData.
class AppTypography {
  AppTypography._(); // Constructor privado para evitar instanciación innecesaria.

  // ==========================================
  // 1. Títulos principales (Headers / App Titles)
  // ==========================================

  /// Título de gran impacto visual (ej. pantalla de login, marcas o splash).
  static const TextStyle displayLarge = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryPurple,
    letterSpacing: -0.5,
  );

  /// Título principal de pantallas o vistas principales.
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  /// Título de app bar o encabezados medianos.
  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryPurple,
  );

  // ==========================================
  // 2. Subtítulos y Encabezados de secciones
  // ==========================================

  /// Subtítulos destacados para tarjetas modales o detalles.
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// Encabezados de categorías o secciones (ej. configuración, agrupadores).
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  // ==========================================
  // 3. Texto normal y descriptivo (Body)
  // ==========================================

  /// Texto normal principal para contenido regular y lectura estándar.
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  /// Texto descriptivo secundario o explicativo (ej. mensajes de ayuda o notas).
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // ==========================================
  // 4. Etiquetas y textos auxiliares (Captions / Hints)
  // ==========================================

  /// Etiquetas pequeñas, marcas de fecha o badges informativos.
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );

  /// Texto auxiliar para campos de búsqueda y placeholders (hintText).
  static const TextStyle hint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.searchIcon,
  );

  // ==========================================
  // 5. Botones y acciones interactivas
  // ==========================================

  /// Texto estándar para botones principales y de confirmación.
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  /// Texto para botones secundarios o enlaces clicables.
  static const TextStyle buttonSecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPurple,
  );

  // ==========================================
  // 6. TextTheme integrado para Flutter Material
  // ==========================================

  /// Configuración lista para usarse en el ThemeData(textTheme: ...) de Flutter.
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
}
