import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomDateFilter extends StatelessWidget {
  final String startDate;
  final String endDate;
  final VoidCallback? onStartDateTap;
  final VoidCallback? onEndDateTap;
  final VoidCallback? onFilterPressed;

  const CustomDateFilter({
    super.key,
    this.startDate = 'Fecha inicial',
    this.endDate = 'Fecha final',
    this.onStartDateTap,
    this.onEndDateTap,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filtrar por fecha',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: _dateField(
                text: startDate,
                onTap: onStartDateTap,
              ),
            ),

            const SizedBox(width: 4),

            Expanded(
              child: _dateField(
                text: endDate,
                onTap: onEndDateTap,
              ),
            ),

            const SizedBox(width: 4),

            GestureDetector(
              onTap: onFilterPressed,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.filter_alt_outlined,
                  color: AppColors.white,
                ),
              ),
            ),                
          ],
        ),
      ],
    );
  }

  Widget _dateField({
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.borderGrey,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.primaryPurple,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}