import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import 'widgets/product_search_bar.dart';
import 'widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FA),
      appBar: const AppHeader(titulo: 'Catálogo de Productos'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: const [
              ProductSearchBar(),
              SizedBox(height: 16),
              ProductCard(
                nombre: 'Shampoo Revitalizante',
                sku: 'SKU: SH-1029',
                precio: '\C24o.00',
                icono: Icons.shopping_bag_rounded,
              ),

              SizedBox(height: 12),
              ProductCard(
                nombre: 'Acondicionador Color\nProtec',
                sku: 'SKU: AC-2041',
                precio: '\C260.00',
                icono: Icons.shopping_bag_rounded,
              ),

              SizedBox(height: 12),
              ProductCard(
                nombre: 'Mascarilla Hidratación\nProfunda',
                precio: '\C200.00',
                icono: Icons.shopping_bag_rounded,
                sinStock: true,
              ),
              SizedBox(height: 20),
             
              CustomPagination(paginaActual: 6),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(pestanaActiva: 'Productos'),
    );
  }
}
