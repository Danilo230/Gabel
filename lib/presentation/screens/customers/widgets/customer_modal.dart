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
          _field(label: 'Nombre', value: customer.customerName),
          const SizedBox(height: 16),
          _field(label: 'Apellido', value: customer.customerLastName),
          const SizedBox(height: 16),
          _field(label: 'Correo', value: customer.customerEmail),
          const SizedBox(height: 16),
          _field(label: 'Teléfono', value: customer.customerPhone),
          const SizedBox(height: 16),
          const Text(
            'Estado',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          _chip(
            customer.customerStatus,
            background: AppColors.mediumPurple,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _field({required String label, required String value}) {
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
          ),
        ),
      ],
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
