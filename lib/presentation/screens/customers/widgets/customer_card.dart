import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../models/customer.dart';
import '../../customers/widgets/customer_edit_modal.dart';
import '../../../widgets/custom_delete.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 135.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadowColor,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${customer.customerName} ${customer.customerLastName}',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 7.0),
          Text(
            customer.customerPhone,
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.visibility_outlined,
                  color: AppColors.actionIcon,
                  size: 20,
                ),
                onPressed: () {
                  CustomerEditModal.show(context, customer);
                },
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.deleteIcon,
                  size: 20,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const CustomDeleteDialog(
                      title: 'Eliminar cliente',
                      message:
                          '¿Estás seguro de que deseas eliminar este cliente?',
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
