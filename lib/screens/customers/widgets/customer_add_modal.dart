import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class NewCustomerModal extends StatelessWidget {
  const NewCustomerModal({super.Key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NewCustomerModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPurple,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: AppColors.iconGrey),
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),
              _field(
              label: 'Nombre del cliente',
              hint: 'Ej. Marie',
            ),
            const SizedBox(height: 16),
              _field(
              label: 'Apellido del cliente',
              hint: 'Ej. Lopez',
            ),
            const SizedBox(height: 14),
            _field(
              label: 'Email',
              hint: 'Ej. MarieLopez@example.com',
              maxLines: 3,
            ),
            const SizedBox(height: 14),

          ),
        ),
      );
  }
}
