import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/search_bar_add.dart';
import '../products/widgets/product_card.dart';
import '../products/widgets/product_modal.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

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
              ),
              SizedBox(height: 12),

              const ProductCard(
                name: 'Shampoo Revitalizante',
                price: '\$240.00',
              ),
              const SizedBox(height: 12),

              const ProductCard(
                name: 'Acondicionador Color\nProtec',
                price: '\$260.00',
              ),
              const SizedBox(height: 12),

              const ProductCard(
                name: 'Mascarilla Hidratación\nProfunda',
                price: '\$200.00',
              ),
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
