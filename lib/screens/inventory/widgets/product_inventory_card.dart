import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../models/product.dart';

// tarjeta que muestra la informacion de un producto en el inventario

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
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: lowStock
                            ? AppColors.lightRed
                            : AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Stock: ${product.stock}',
                        style: TextStyle(
                          fontSize: 13,
                          color: lowStock
                              ? AppColors.red
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
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
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onViewDetail,
            tooltip: 'Ver detalle',
            icon: const Icon(Icons.remove_red_eye_outlined,
                size: 23, color: AppColors.primaryPurple),
          ),
          IconButton(
            onPressed: onRegisterDamage,
            tooltip: 'Registrar daño',
            icon: const Icon(Icons.warning_amber_rounded,
                size: 23, color: AppColors.strongRed),
          ),
        ],
      ),
    );
  }
}
