import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import '../services/widgets/service_modal.dart';
<<<<<<< HEAD:lib/screens/services/services.dart
import '../../widgets/search_bar_add.dart';
=======
import '../../widgets/search_bar_add.dart'; 
>>>>>>> origin/develop:lib/presentation/screens/services/services.dart
import 'widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Catálogo de Servicios'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: [
<<<<<<< HEAD:lib/screens/services/services.dart
=======

>>>>>>> origin/develop:lib/presentation/screens/services/services.dart
              SearchBarAdd(
                onAddPressed: () {
                  NewServiceModal.show(context);
                },
              ),
<<<<<<< HEAD:lib/screens/services/services.dart
              SizedBox(height: 12),
=======
             SizedBox(height: 12),
>>>>>>> origin/develop:lib/presentation/screens/services/services.dart

              const ServiceCard(
                name: 'Corte de Cabello y Estilo',
                price: '\C18.00',
              ),
              const SizedBox(height: 12),

              const ServiceCard(
                name: 'Tinte y Tratamiento Capilar',
                price: '\$45.00',
              ),
              const SizedBox(height: 20),

              const CustomPagination(currentPage: 6),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Servicios'),
    );
  }
}
