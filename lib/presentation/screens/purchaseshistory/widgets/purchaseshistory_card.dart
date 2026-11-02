import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import 'package:gabel/core/utils/format_date.dart';
import 'package:gabel/data/models/purchase_model.dart';

class PurchaseCard extends StatelessWidget {
  final PurchaseModel purchase;
  final VoidCallback? onViewDetail;

  const PurchaseCard({
    super.key,
    required this.purchase,
    this.onViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderGrey,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Proveedor',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      purchase.supplierName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'C\$${purchase.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Divider(
            height: 1,
            color: AppColors.borderGrey,
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Text(
                formatDate(purchase.purchaseDate),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              IconButton(
                onPressed: onViewDetail,
                tooltip: 'Ver detalle',
                icon: const Icon(
                  Icons.visibility_outlined,
                  size: 23,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}