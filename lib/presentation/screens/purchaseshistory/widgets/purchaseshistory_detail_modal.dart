import 'package:flutter/material.dart';
import 'package:gabel/presentation/providers/purchase_provider.dart';
import 'package:gabel/presentation/widgets/custom_modal_sheet.dart';
import 'package:gabel/presentation/widgets/error_view.dart';
import 'package:gabel/presentation/widgets/loading_view.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_colors.dart';
import 'package:gabel/core/utils/format_date.dart';
import 'package:gabel/data/models/purchase_detail_model.dart';
import 'package:gabel/data/models/purchase_with_details_model.dart';

class PurchaseDetailModal extends StatelessWidget {
  final PurchaseWithDetailsModel purchase;

  const PurchaseDetailModal({super.key, required this.purchase});

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
            formatDate(purchase.purchaseDate),
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

          ...purchase.details.map(
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

  Widget _productDetail(PurchaseDetailModel detail) {
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
            'C\$${detail.totalAmount.toStringAsFixed(2)}',
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

class PurchaseDetailSheet extends StatelessWidget {
  const PurchaseDetailSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<PurchaseProvider>();
    final purchase = p.selectedPurchase;

    if (p.detailStatus == ViewStatusPurchase.success && purchase != null) {
      return PurchaseDetailModal(purchase: purchase);
    }

    if (p.detailStatus == ViewStatusPurchase.error) {
      return CustomModalSheet(
        title: 'Detalle de compra',
        child: SizedBox(
          height: 220,
          child: ErrorView(
            errorMessage: p.detailErrorMessage ?? 'Error desconocido',
          ),
        ),
      );
    }

    return const CustomModalSheet(
      title: 'Detalle de compra',
      child: SizedBox(
        height: 220,
        child: LoadingView(message: 'Cargando detalle...'),
      ),
    );
  }
}