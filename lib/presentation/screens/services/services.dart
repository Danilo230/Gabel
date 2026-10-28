import 'package:flutter/material.dart';
import 'package:gabel/data/models/service_models.dart';
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

  static const List<String> Stilist = [
    'Seleccionar estilista',
    'María García',
    'Ana López',
    'Laura Martínez',
  ];
  String selectedFilter = filter.first;
  String selectedStilist = Stilist.first;

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
              value: selectedStilist,
              items: Stilist,
              onChanged: (val) {
                if (val != null) {
                  setModalState(() => selectedStilist = val);
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

              ServiceCard(
                service: ServiceModels(
                  serviceId: 1,
                  serviceName: 'Keratina',
                  serviceDescription: 'Alizado permanante',
                  servicePrice: '\$200',
                  serviceStilist: 'Maria',
                  serviceStatus: true,
                ),
              ),
              const SizedBox(height: 16),
              ServiceCard(
                service: ServiceModels(
                  serviceId: 2,
                  serviceName: 'Alisado profecional',
                  serviceDescription: 'Planchado',
                  servicePrice: '\$100',
                  serviceStilist: 'Nathalia',
                  serviceStatus: true,
                ),
              ),
              const SizedBox(height: 16),
              ServiceCard(
                service: ServiceModels(
                  serviceId: 3,
                  serviceName: 'Keratina permanante',
                  serviceDescription: 'hidratacion capilar',
                  servicePrice: '\$300',
                  serviceStilist: 'Martha',
                  serviceStatus: true,
                ),
              ),
              const SizedBox(height: 16),
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
