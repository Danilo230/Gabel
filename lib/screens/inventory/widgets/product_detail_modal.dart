import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../models/product.dart';

// modal que muestra el detalle de un producto en el inventario

class ProductDetailModal extends StatelessWidget {
  final Product product;

  const ProductDetailModal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de Producto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _chip(
                product.category,
                background: AppColors.mediumPurple,
                textColor: Colors.white,
              ),
              const SizedBox(width: 10),
              _chip(
                product.isActive ? 'Activo' : 'Inactivo',
                background: AppColors.lightGrey,
                textColor: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 18),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _stockBox(
                    icon: Icons.inventory_2_rounded,
                    label: 'Stock Disponible',
                    value: '${product.stock}',
                    accent: AppColors.mediumPurple,
                    valueColor: AppColors.textPrimary,
                    labelColor: AppColors.textPrimary,
                    background: AppColors.white,
                    border: AppColors.borderGrey,
                    bold: false,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _stockBox(
                    icon: Icons.warning_rounded,
                    label: 'Stock Dañado',
                    value: '${product.damagedStock}',
                    accent: AppColors.red,
                    valueColor: AppColors.red,
                    labelColor: AppColors.red,
                    background: AppColors.paleRed,
                    border: AppColors.redBorder,
                    bold: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _priceBox(
            icon: Icons.sell_outlined,
            label: 'Precio de Venta',
            value: '\$${product.salePrice.toStringAsFixed(2)}',
            trailingLabel: 'Margen',
            trailingValue: '${product.margin}%',
            trailingLabelColor: AppColors.primaryPurple,
          ),
          const SizedBox(height: 14),
          _priceBox(
            icon: Icons.shopping_cart_outlined,
            label: 'Precio de Compra',
            value: '\$${product.purchasePrice.toStringAsFixed(2)}',
            trailingLabel: 'ultima compra',
            trailingValue: product.lastPurchase,
            trailingLabelColor: AppColors.textSecondary,
          ),
          const SizedBox(height: 26),
          CustomButton(
            text: 'Cerrar',
            type: ButtonType.neutral,
            onPressed: () => Navigator.of(context).pop(),
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
        borderRadius: BorderRadius.circular(20),
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

  Widget _stockBox({
    required IconData icon,
    required String label,
    required String value,
    required Color accent,
    required Color valueColor,
    required Color labelColor,
    required Color background,
    required Color border,
    required bool bold,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: accent),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: labelColor,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'uds',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceBox({
    required IconData icon,
    required String label,
    required String value,
    required String trailingLabel,
    required String trailingValue,
    required Color trailingLabelColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.paleLavender,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                trailingLabel,
                style: TextStyle(fontSize: 13, color: trailingLabelColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                trailingValue,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
