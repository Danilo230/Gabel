import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import 'widgets/customer_card.dart';
import 'widgets/customer_search_bar.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FA),
      appBar: const AppHeader(titulo: 'Catalógo de Clientes'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: const [
              CustomerSearchBar(),
              SizedBox(height: 12),
              CustomerCard(
                customerName: 'Juan',
                customerLastName: 'Pérez',
                customerEmail: 'juan.perez@example.com',
                customerPhone: '+505 88923213',
              ),
              SizedBox(height: 12),
              CustomerCard(
                customerName: 'María',
                customerLastName: 'González',
                customerEmail: 'maria.gonzalez@example.com',
                customerPhone: '+505 88923214',
              ),
              SizedBox(height: 12),
              CustomerCard(
                customerName: 'Carlos',
                customerLastName: 'Ramírez',
                customerEmail: 'carlos.ramirez@example.com',
                customerPhone: '+505 88923215',
              ),
              SizedBox(height: 12),
              CustomPagination(paginaActual: 3),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(pestanaActiva: 'Clientes'),
    );
  }
}
