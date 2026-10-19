import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomFilterDropdown extends StatelessWidget {
  final String label;
<<<<<<< HEAD:lib/widgets/custom_filter_dropdown.dart
  final String? value;
  final String? hint;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final bool enabled;
=======
  final String value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
>>>>>>> origin/develop:lib/presentation/widgets/custom_filter_dropdown.dart

  const CustomFilterDropdown({
    super.key,
    required this.label,
<<<<<<< HEAD:lib/widgets/custom_filter_dropdown.dart
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.enabled = true,
=======
    required this.value,
    required this.items,
    this.onChanged,
>>>>>>> origin/develop:lib/presentation/widgets/custom_filter_dropdown.dart
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD:lib/widgets/custom_filter_dropdown.dart
            border: Border.all(color: AppColors.borderGrey),
=======
            border: Border.all(
              color: AppColors.borderGrey,
            ),
>>>>>>> origin/develop:lib/presentation/widgets/custom_filter_dropdown.dart
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryPurple,
              ),
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
<<<<<<< HEAD:lib/widgets/custom_filter_dropdown.dart
                  child: Text(item, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: enabled ? onChanged : null,
=======
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
>>>>>>> origin/develop:lib/presentation/widgets/custom_filter_dropdown.dart
            ),
          ),
        ),
      ],
    );
  }
<<<<<<< HEAD:lib/widgets/custom_filter_dropdown.dart
}
=======
}
>>>>>>> origin/develop:lib/presentation/widgets/custom_filter_dropdown.dart
