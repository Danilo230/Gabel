import 'package:flutter/material.dart';
import '../models/productmodel.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';

class ProductDetailModal extends StatelessWidget {
  final Product product;

  const ProductDetailModal({
    super.key,
    required this.product,
  });

  static void show(BuildContext context, {required Product product}) {
    CustomModalSheet.show(
      context: context,
      child: ProductDetailModal(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de producto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailField(label: 'Nombre del producto', value: product.name),
          const SizedBox(height: 14),

          _DetailField(label: 'Descripción', value: product.description),
          const SizedBox(height: 14),

          _DetailField(label: 'Marca', value: product.brand),
          const SizedBox(height: 14),

          _DetailField(label: 'Unidad de Medida', value: product.unitOfMeasure),
          const SizedBox(height: 14),

          _DetailField(label: 'Categoría', value: product.category),
          const SizedBox(height: 14),

          _DetailField(label: 'Proveedor', value: product.supplier),
          const SizedBox(height: 14),

          _DetailField(label: 'Precio', value: product.price),
          const SizedBox(height: 14),

          _StatusField(label: 'Estado', status: product.status),
        ],
      ),
    );
  }

  Widget _DetailField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderGrey),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _StatusField({required String label, required String status}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.mediumPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}