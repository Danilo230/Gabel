import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../models/customer.dart';

class CustomerDetailModal extends StatelessWidget {
  final Customer customer;

  const CustomerDetailModal({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de cliente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _chip(
            customer.customerStatus,
            background: AppColors.mediumPurple,
            textColor: AppColors.white,
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                customer.customerName,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              Text(
                customer.customerLastName,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                customer.customerEmail,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              Text(
                customer.customerPhone,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(
    String label, {
    required Color background,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
