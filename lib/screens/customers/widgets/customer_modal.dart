import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../models/customer.dart';

class CustomerDetailModal extends StatelessWidget {
  final Customer customer;

  const CustomerDetailModal({super.key, required this.customer});

  static void show(BuildContext context, Customer customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.45),
      builder: (context) {
        return CustomerDetailModal(customer: customer);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de cliente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _chip(
            customer.customerStatus,
            background: AppColors.mediumPurple,
            textColor: AppColors.white,
          ),

          SizedBox(height: 20),
          Text(
            customer.customerName,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          SizedBox(height: 20),
          Text(
            customer.customerLastName,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          SizedBox(height: 20),
          Text(
            customer.customerEmail,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          SizedBox(height: 20),
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
