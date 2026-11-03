import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_delete.dart';
import 'edit_product_modal.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  Future<void> _deleteProduct(BuildContext context) async {
    final provider = context.read<ProductProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const CustomDeleteDialog(
        message: '¿Estás seguro de que deseas eliminar este producto?',
      ),
    );
    if (confirmed != true) return;

    final message = await provider.delete(product.productId);

    if (message != null) {
      await provider.refresh();
      messenger.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.deleteIcon,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            provider.errorMessage ?? 'Error al eliminar el producto.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
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
          Text(
            product.productName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
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
                    product.brand.isNotEmpty ? product.brand : 'Sin marca',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: product.productStatus
                          ? AppColors.lightGreen
                          : AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.productStatus ? 'Activo' : 'Inactivo',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.visibility_outlined,
                          color: AppColors.actionIcon,
                          size: 20,
                        ),
                        onPressed: () {
                          EditProductModal.show(context, product);
                        },
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.deleteIcon,
                          size: 20,
                        ),
                        onPressed: () => _deleteProduct(context),
                      ),
                    ],
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
