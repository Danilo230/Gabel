import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:gabel/presentation/providers/customer_provider.dart';
import 'package:gabel/data/models/customer_model.dart';
import '../../customers/widgets/customer_edit_modal.dart';
import '../../../widgets/custom_delete.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;

  const CustomerCard({super.key, required this.customer});

  Future<void> _deleteCustomer(BuildContext context) async {
    final provider = context.read<CustomerProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const CustomDeleteDialog(
        message: '¿Estás seguro de que deseas eliminar este cliente?',
      ),
    );
    if (confirmed != true) return;
    final message = await provider.delete(customer.customerId);

    if (message != null) {
      await provider.refresh();
      messenger.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.deleteIcon,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            provider.errorMessage ?? 'Error al eliminar el cliente.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Teléfono',
                    style: TextStyle(
                      color: AppColors.cardTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    customer.customerPhone,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
               const SizedBox(height: 9),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: customer.customerStatus ? AppColors.lightGreen : AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      customer.customerStatus ? 'Activo' : 'Inactivo',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,

                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                        onPressed: () => _deleteCustomer(context),
                      ),
                    ],
                  )


                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
