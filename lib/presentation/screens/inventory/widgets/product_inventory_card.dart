import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../models/product.dart';

class ProductInventoryCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onViewDetail;
  final VoidCallback? onRegisterDamage;

  const ProductInventoryCard({
    super.key,
    required this.product,
    this.onViewDetail,
    this.onRegisterDamage,
  });

  @override
  Widget build(BuildContext context) {
    final bool lowStock = product.isLowStock;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Producto',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.name,
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
                    '\$${product.salePrice.toStringAsFixed(2)}',
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
          const Divider(height: 1, color: AppColors.borderGrey),

          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 15,
                color: lowStock ? AppColors.red : AppColors.textTertiary,
              ),
              const SizedBox(width: 6),
              Text(
                'Stock: ${product.stock} uds',
                style: TextStyle(
                  fontSize: 14,
                  color: lowStock ? AppColors.red : AppColors.textSecondary,
                  fontWeight: lowStock ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: onViewDetail,
                    tooltip: 'Ver detalle',
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 24,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                  const SizedBox(width: 14),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: onRegisterDamage,
                    tooltip: 'Registrar daño',
                    icon: const Icon(
                      Icons.warning_amber_rounded,
                      size: 24,
                      color: AppColors.deleteIcon,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
