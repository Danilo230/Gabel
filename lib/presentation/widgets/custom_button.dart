import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// un boton personalizable, no hay mucho que decir

enum ButtonType { primary, danger, neutral }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
  });

  Color get _background {
    switch (type) {
      case ButtonType.primary:
        return AppColors.primaryPurple;
      case ButtonType.danger:
        return AppColors.strongRed;
      case ButtonType.neutral:
        return AppColors.lightGrey;
    }
  }

  Color get _foreground =>
      type == ButtonType.neutral ? AppColors.textPrimary : Colors.white;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _background,
          foregroundColor: _foreground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: _foreground),
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
