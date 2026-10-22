import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/search_bar_add.dart';
import '../products/widgets/product_card.dart';
import '../products/widgets/product_modal.dart';
import '../../widgets/custom_filter_modal.dart';
import '../../widgets/custom_filter_dropdown.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  static const List<String> filter = ['Marca', 'Proveedor', 'Categoria'];

  static const List<String> brands = [
    'Seleccionar marca',
    'Sedal',
    'Pantene',
    'Garnier',
    'Head & Shoulders',
  ];
  String selectedBrand = brands.first;
  String selectedFilter = filter.first;

  void _openFilterModal() {
    CustomFilterModal.show(
      context,
      title: 'Filtrar Productos',
      builder: (modalContext, setModalState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFilterDropdown(
              label: 'Filtrar por',
              value: selectedFilter,
              items: filter,
              onChanged: (val) {
                if (val != null) {
                  setModalState(() => selectedFilter = val);
                }
              },
            ),
            const SizedBox(height: 16),

            CustomFilterDropdown(
              label: 'Seleccionar',
              value: selectedBrand,
              items: brands,
              onChanged: (val) {
                if (val != null) {
                  setModalState(() => selectedBrand = val);
                }
              },
            ),
          ],
        );
      },
      onApply: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgtextColor,
      appBar: const AppHeader(title: 'Catálogo de Productos'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: [
              SearchBarAdd(
                onAddPressed: () {
                  NewProductModal.show(context);
                },
                onFilterPressed: _openFilterModal,
              ),
              SizedBox(height: 16),

              const ProductCard(name: 'Shampoo Revitalizante'),
              const SizedBox(height: 12),

              const ProductCard(name: 'Acondicionador Color\nProtec'),
              const SizedBox(height: 12),

              const ProductCard(name: 'Mascarilla Hidratación\nProfunda'),
              const SizedBox(height: 20),

              const CustomPagination(currentPage: 6),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Productos'),
    );
  }
}
