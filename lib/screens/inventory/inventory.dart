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
  static const int _itemsPerPage = 5;

  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  int _currentPage = 1;

  final List<Product> _products = const [
    Product(
      name: 'Shampoo Keratina 500ml',
      stock: 24,
      salePrice: 15.00,
      purchasePrice: 9.10,
      margin: 39,
      damagedStock: 1,
      lastPurchase: '12 May 2024',
    ),
    Product(
      name: 'Acondicionador Color Care',
      stock: 3,
      salePrice: 18.50,
      purchasePrice: 11.30,
      margin: 39,
      lastPurchase: '02 Jun 2024',
    ),
    Product(
      name: 'Mascarilla Hidratacion Profunda',
      stock: 12,
      salePrice: 22.00,
      purchasePrice: 13.40,
      margin: 39,
      lastPurchase: '28 Abr 2024',
    ),
    Product(
      name: 'Tinte Profesional Castaño Oscuro',
      stock: 45,
      salePrice: 9.00,
      purchasePrice: 5.20,
      margin: 42,
      damagedStock: 2,
      lastPurchase: '12 May 2024',
    ),
    Product(
      name: 'Shampoo Matizador Violeta 500ml',
      stock: 18,
      salePrice: 24.50,
      purchasePrice: 14.20,
      margin: 42,
      damagedStock: 2,
      lastPurchase: '12 May 2024',
    ),
    Product(
      name: 'Aceite de Argsn 100ml',
      stock: 30,
      salePrice: 16.00,
      purchasePrice: 9.80,
      margin: 39,
      lastPurchase: '05 Jun 2024',
    ),
    Product(
      name: 'Serum Reparador de Puntas',
      stock: 8,
      salePrice: 19.90,
      purchasePrice: 12.10,
      margin: 39,
      lastPurchase: '20 May 2024',
    ),
    Product(
      name: 'Crema para Peinar sin Enjuague',
      stock: 27,
      salePrice: 13.50,
      purchasePrice: 8.00,
      margin: 41,
      lastPurchase: '30 May 2024',
    ),
    Product(
      name: 'Ampolletas de Keratina (caja)',
      stock: 4,
      salePrice: 28.00,
      purchasePrice: 17.50,
      margin: 38,
      lastPurchase: '15 May 2024',
    ),
    Product(
      name: 'Protector Termico en Spray',
      stock: 21,
      salePrice: 14.00,
      purchasePrice: 8.60,
      margin: 39,
      lastPurchase: '08 Jun 2024',
    ),
    Product(
      name: 'Decolorante en Polvo 500g',
      stock: 15,
      salePrice: 20.00,
      purchasePrice: 12.30,
      margin: 39,
      lastPurchase: '22 May 2024',
    ),
    Product(
      name: 'Oxidante Crema Vol. 30',
      stock: 33,
      salePrice: 8.50,
      purchasePrice: 5.00,
      margin: 41,
      lastPurchase: '18 May 2024',
    ),
    Product(
      name: 'Guantes de Nitrilo (caja x50)',
      stock: 2,
      salePrice: 6.00,
      purchasePrice: 3.40,
      margin: 43,
      lastPurchase: '01 Jun 2024',
    ),
    Product(
      name: 'Papel Aluminio para Mechas',
      stock: 40,
      salePrice: 7.20,
      purchasePrice: 4.10,
      margin: 43,
      lastPurchase: '10 May 2024',
    ),
    Product(
      name: 'Gel Fijador Extra Fuerte',
      stock: 17,
      salePrice: 10.50,
      purchasePrice: 6.20,
      margin: 41,
      lastPurchase: '25 May 2024',
    ),
    Product(
      name: 'Spray de Brillo Final',
      stock: 6,
      salePrice: 11.80,
      purchasePrice: 7.00,
      margin: 40,
      lastPurchase: '03 Jun 2024',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredProducts {
    if (_query.trim().isEmpty) return _products;
    final String q = _query.toLowerCase();
    return _products.where((p) => p.name.toLowerCase().contains(q)).toList();
  }

  int get _totalPages {
    final int count = _filteredProducts.length;
    if (count == 0) return 1;
    return (count / _itemsPerPage).ceil();

  }

  List<Product> get _pageProducts {
    final List<Product> filtered = _filteredProducts;
    final int start = (_currentPage - 1) * _itemsPerPage;
    if (start >= filtered.length) return const [];
    final int end =
        start + _itemsPerPage > filtered.length
            ? filtered.length
            : start + _itemsPerPage;
    return filtered.sublist(start, end);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      _currentPage = 1;
    });
  }

  void _onPageTap(int page) {
    if (page < 1 || page > _totalPages) return;
    setState(() => _currentPage = page);
  }

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
    final List<Product> products = _pageProducts;
    final int totalPages = _totalPages;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'Inventario',
        backgroundColor: AppColors.background,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        activeTab: 'Inventario',
        onItemTap: widget.onTabChange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
            child: CustomSearchBar(
              hintText: 'Buscar productos...',
              controller: _searchController,
              onChanged: _onSearchChanged,
              onFilterTap: () {},
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
          if (products.isNotEmpty && totalPages > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Center(
                child: CustomPagination(
                  currentPage: _currentPage,
                  totalPages: totalPages,
                  onPageTap: _onPageTap,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
