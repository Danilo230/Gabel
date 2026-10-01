import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SearchBarAdd extends StatelessWidget {
  final String hintText;
  final VoidCallback? onAddPressed;

  const SearchBarAdd({
    super.key,
    this.hintText = 'Buscar...',
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF9E9E9E), size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    hintText,
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.tune,
                  color: AppColors.primaryPurple,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: AppColors.primaryPurple,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onAddPressed,
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ),
      ],
    );
  }
}
