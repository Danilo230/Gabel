import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'custom_modal_sheet.dart';

class CustomFilterModal extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext context, StateSetter setModalState)
  builder;
  final VoidCallback onApply;
  final String applyButtonText;

  const CustomFilterModal({
    super.key,
    this.title = 'Filtros',
    required this.builder,
    required this.onApply,
    this.applyButtonText = 'Aplicar Filtros',
  });

  static Future<void> show(
    BuildContext context, {
    String title = '',
    required Widget Function(BuildContext context, StateSetter setModalState)
    builder,
    required VoidCallback onApply,
    String applyButtonText = 'Filtrar',
  }) {
    return CustomModalSheet.show(
      context: context,
      child: CustomFilterModal(
        title: title,
        builder: builder,
        onApply: onApply,
        applyButtonText: applyButtonText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: title,
      child: StatefulBuilder(
        builder: (modalContext, setModalState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              builder(modalContext, setModalState),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    onApply();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.white,
                    size: 20,
                  ),
                  label: Text(
                    applyButtonText,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
