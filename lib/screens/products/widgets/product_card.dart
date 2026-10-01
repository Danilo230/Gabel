import 'package:flutter/material.dart';
import '../models/productmodel.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_delete.dart';
import 'edit_product_modal.dart';
import 'product_detail_modal.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final IconData icon;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.icon = Icons.shopping_bag_rounded,
  });

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.bgIconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: AppColors.actionIcon,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Precio',
                    style: TextStyle(
                      color: AppColors.cardTextSecondary,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.actionIcon,
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
                    onPressed: () {
                      ProductDetailModal.show(
                        context,
                        product: Product(
                          name: name,
                          price: price,
                          description: 'Fijación fuerte con acabado mate natural sin residuos.',
                          brand: 'Styling Pro',
                          category: 'Fijación',
                          supplier: 'Distribuidora Belleza S.A.',
                          unitOfMeasure: '150 ml',
                          status: 'Activo',

                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.actionIcon,
                      size: 20,
                    ),
                    onPressed: () {
                      EditProductModal.show(context);
                    },
                  ),
                  const SizedBox(width: 16),

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.deleteIcon,
                      size: 20,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CustomDeleteDialog(
                          titulo: 'Eliminar',
                          mensaje: '¿Deseas eliminar este producto?',
                        ),
                      );
                    },
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