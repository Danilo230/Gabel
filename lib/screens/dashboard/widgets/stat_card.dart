import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

// tarjeta que muestra una estadistica con icono, etiqueta y valor

enum StatStyle { purple, neutral, danger }

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final StatStyle style;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.style = StatStyle.purple,
    this.onTap,
  });

  Color get _cardBackground =>
      style == StatStyle.danger ? AppColors.lightRed : AppColors.white;

  Color get _cardBorder =>
      style == StatStyle.danger ? AppColors.redBorder : AppColors.borderGrey;

  Color get _iconBackground {
    switch (style) {
      case StatStyle.purple:
        return AppColors.lightPurple;
      case StatStyle.neutral:
        return AppColors.lightGrey;
      case StatStyle.danger:
        return AppColors.dangerIconBg;
    }
  }

  Color get _iconColor {
    switch (style) {
      case StatStyle.purple:
        return AppColors.primaryPurple;
      case StatStyle.neutral:
        return AppColors.iconGrey;
      case StatStyle.danger:
        return AppColors.red;
    }
  }

  Color get _valueColor =>
      style == StatStyle.danger ? AppColors.red : AppColors.textPrimary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _cardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: _iconColor),
            ),
            const SizedBox(height: 18),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: _valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
