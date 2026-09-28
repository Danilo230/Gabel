import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_modal_sheet.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/custom_search_bar.dart';
import 'models/product.dart';
import 'widgets/product_detail_modal.dart';
import 'widgets/product_inventory_card.dart';
import 'widgets/register_damage_modal.dart';

class InventoryScreen extends StatefulWidget {
  final ValueChanged<String>? onTabChange;

  const InventoryScreen({super.key, this.onTabChange});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<Product> _products = const [
    Product(
      name: 'Shampoo Keratina 500ml',
      stock: 24,
      salePrice: 15.00,
      purchasePrice: 9.10,
      margin: 39,
      damagedStock: 1,
      lastPurchase: '12 May 2026',
    ),
    Product(
      name: 'Acondicionador Color Care',
      stock: 3,
      salePrice: 18.50,
      purchasePrice: 11.30,
      margin: 39,
      lastPurchase: '02 Jun 2026',
    ),
    Product(
      name: 'Mascarilla Hidratacion Profunda',
      stock: 12,
      salePrice: 22.00,
      purchasePrice: 13.40,
      margin: 39,
      lastPurchase: '28 Abr 2026',
    ),
    Product(
      name: 'Tinte Profesional Castaño Oscuro',
      stock: 45,
      salePrice: 9.00,
      purchasePrice: 5.20,
      margin: 42,
      damagedStock: 2,
      lastPurchase: '12 May 2026',
    ),
  ];

  void _openDetail(Product product) {
    CustomModalSheet.show(
      context: context,
      child: ProductDetailModal(product: product),
    );
  }

  Future<void> _openDamageForm(Product product) async {
    final DamageRecord? record = await CustomModalSheet.show<DamageRecord>(
      context: context,
      child: RegisterDamageModal(product: product),
    );

    if (record == null || !mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryPurple,
        content: Text(
          'Se registraron ${record.quantity} uds dañadas de ${product.name}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products = _products;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'Inventario',
      ),
      bottomNavigationBar: CustomBottomNavBar(
        activeTab: 'Inventario',
        onItemTap: widget.onTabChange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 18),
            child: CustomSearchBar(
              hintText: 'Buscar productos...',
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? const Center(
                    child: Text(
                      'No se encontraron productos.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final Product product = products[index];
                      return ProductInventoryCard(
                        product: product,
                        onViewDetail: () => _openDetail(product),
                        onRegisterDamage: () => _openDamageForm(product),
                      );
                    },
                  ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Center(
              child: CustomPagination(
                currentPage: 3,
                totalPages: 7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
