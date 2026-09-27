import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../models/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  final VoidCallback? onViewDetail;

  const CustomerCard({super.key, required this.customer, this.onViewDetail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150.0,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${customer.customerName} ${customer.customerLastName}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                customer.customerEmail,
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                customer.customerPhone,
                style: const TextStyle(fontSize: 14.0),
              ),
              Text(
                customer.customerStatus,
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 8.0),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.actionIcon,
                    size: 20,
                  ),
                  SizedBox(width: 16),
                  Icon(
                    Icons.edit_outlined,
                    color: AppColors.actionIcon,
                    size: 20,
                  ),
                  SizedBox(width: 16),
                  Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.deleteIcon,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
