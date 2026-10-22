import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_filter_dropdown.dart';
import '../../widgets/custom_filter_modal.dart';
import '../../widgets/custom_pagination.dart';
import '../services/widgets/service_modal.dart';
import '../../widgets/search_bar_add.dart';
import 'widgets/service_card.dart';
import '../../theme/app_colors.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  static const List<String> filter = ['Estilista'];

  static const List<String> estilist = [
    'Seleccionar estilista',
    'María García',
    'Ana López',
    'Laura Martínez',
  ];
  String selectedFilter = filter.first;
  String selectedEstilist = estilist.first;

  void _openFilterModal() {
    CustomFilterModal.show(
      context,
      title: 'Filtrar Servicios',
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
              label: 'Servicio',
              value: selectedEstilist,
              items: estilist,
              onChanged: (val) {
                if (val != null) {
                  setModalState(() => selectedEstilist = val);
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
      appBar: const AppHeader(title: 'Catálogo de Servicios'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: [
              SearchBarAdd(
                onAddPressed: () {
                  NewServiceModal.show(context);
                },
                onFilterPressed: _openFilterModal,
              ),
              const SizedBox(height: 16),

              const ServiceCard(
                name: 'Corte de Cabello y Estilo',
                price: '\$18.00',
              ),
              const SizedBox(height: 12),

              const ServiceCard(
                name: 'Tinte y Tratamiento Capilar',
                price: '\$45.00',
              ),
              const SizedBox(height: 20),

              // Paginación
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
