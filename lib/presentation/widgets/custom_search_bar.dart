import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// barra de busqueda con un filtro

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final bool showFilter;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Buscar...',
    this.controller,
    this.onChanged,
    this.onFilterTap,
    this.showFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: AppColors.textTertiary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
          if (showFilter)
            GestureDetector(
              onTap: onFilterTap,
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child:
                    Icon(Icons.tune, size: 22, color: AppColors.primaryPurple),
              ),
            ),
        ],
      ),
    );
  }
}
