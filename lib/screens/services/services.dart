import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import 'widgets/service_search_bar.dart';
import 'widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FA),
      appBar: const AppHeader(title: 'Catálogo de Servicios'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: const [
              ServiceSearchBar(),
              SizedBox(height: 16),
              ServiceCard(
                nombre: 'Corte de Cabello y Estilo',
                productoUtilizado: 'Shampoo Revitalizante',
                precio: '\C18.00',
                icono: Icons.content_cut_rounded,
              ),
              SizedBox(height: 12),
              ServiceCard(
                nombre: 'Tinte y Tratamiento Capilar',
                productoUtilizado: 'Acondicionador Color Protect',
                precio: '\$45.00',
                icono: Icons.brush_outlined,
              ),
              SizedBox(height: 20),
              
              CustomPagination(currentPage: 6),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Servicios'),
    );
  }
}
