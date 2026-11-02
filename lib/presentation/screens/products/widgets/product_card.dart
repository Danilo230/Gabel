import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import '../../../../data/models/product_model.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_delete.dart';
import 'edit_product_modal.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadowColor,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.productName,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Marca',
                    style: TextStyle(
                      color: AppColors.cardTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    product.brand,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.visibility_outlined,
                      color: AppColors.actionIcon,
                      size: 20,
                    ),
                    onPressed: () => EditProductModal.show(context, product),
                  ),
                  const SizedBox(width: 8),

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.deleteIcon,
                      size: 20,
                    ),
                    onPressed: () => _handleDelete(context),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleDelete(BuildContext context) {
    final provider = context.read<ProductProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final id = product.productId;

    showDialog(
      context: context,
      builder: (_) => CustomDeleteDialog(
        message: '¿Deseas eliminar este producto?',
        onConfirm: () async {
          final ok = await provider.deleteProduct(id);

          messenger.showSnackBar(
            SnackBar(
              content: Text(
                ok
                    ? 'Producto eliminado exitosamente.'
                    : provider.errorMessage ??
                          'No se pudo eliminar el producto.',
              ),
              backgroundColor: ok
                  ? AppColors.primaryPurple
                  : AppColors.strongRed,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }
}
