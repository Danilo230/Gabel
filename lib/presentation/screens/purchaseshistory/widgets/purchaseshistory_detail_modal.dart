import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../models/purchasesmodel.dart';

class PurchaseDetailModal extends StatelessWidget {
  final Purchase purchase;
  final List<PurchaseDetail> details;

  const PurchaseDetailModal({
    super.key,
    required this.purchase,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de compra',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            purchase.supplierName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            purchase.purchaseDate,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 20),

          const Divider(
            color: AppColors.borderGrey,
          ),

          const SizedBox(height: 12),

          const Text(
            'Productos comprados',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryPurple,
            ),
          ),

          const SizedBox(height: 14),

          ...details.map(
            (detail) => _productDetail(detail),
          ),

          const SizedBox(height: 12),

          const Divider(
            color: AppColors.borderGrey,
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              Text(
                'C\$${purchase.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _productDetail(PurchaseDetail detail) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderGrey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.productName ?? 'Producto',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 12),

          _detailRow(
            'Cantidad',
            detail.purchaseQuantity.toString(),
          ),

          const SizedBox(height: 8),

          _detailRow(
            'Precio unitario',
            'C\$${detail.unitPrice.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 8),

          _detailRow(
            'Subtotal',
            'C\$${detail.lineTotal.toStringAsFixed(2)}',
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    String label,
    String value, {
    bool highlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: highlight ? 15 : 13,
            fontWeight: FontWeight.bold,
            color: highlight
                ? AppColors.primaryPurple
                : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}