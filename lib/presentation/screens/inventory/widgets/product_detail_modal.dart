import 'package:flutter/material.dart';
import 'package:gabel/core/utils/num_extensions.dart';
import 'package:gabel/data/models/inventory_model.dart';
import 'package:gabel/data/models/product_model.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';

// modal que muestra el detalle de un producto en el inventario

class ProductDetailModal extends StatelessWidget {
  final InventoryModel item;
  final Future<ProductModel?> product;

  const ProductDetailModal({
    super.key,
    required this.item,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de Producto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.productName,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          FutureBuilder<ProductModel?>(
            future: product,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SizedBox(
                  height: 32,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryPurple,
                      ),
                    ),
                  ),
                );
              }

              final ProductModel? data = snapshot.data;
              if (data == null) return const SizedBox.shrink();

              return Row(
                children: [
                  _chip(
                    data.categoryName,
                    background: AppColors.mediumPurple,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  _chip(
                    data.productStatus ? 'Activo' : 'Inactivo',
                    background: AppColors.lightGrey,
                    textColor: AppColors.textSecondary,
                  ),
                ],
              );
            },
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
                    value: item.stock.toQuantityString(),
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
                    value: '${item.damagedStock}',
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
            value: '\$${item.salePrice.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 14),
          _priceBox(
            icon: Icons.shopping_cart_outlined,
            label: 'Precio de Compra',
            value: '\$${item.unitPrice.toStringAsFixed(2)}',
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
          fontSize: 12,
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: accent),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: labelColor,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'uds',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
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
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.paleLavender,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
