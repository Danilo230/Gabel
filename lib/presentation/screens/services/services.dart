import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/presentation/providers/service_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_filter_dropdown.dart';
import '../../widgets/custom_filter_modal.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/custom_refresh_scroll_view.dart';
import '../../widgets/search_bar_add.dart';
import 'widgets/service_card.dart';
import 'widgets/service_modal.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  static const List<String> filterTypes = ['Estado', 'Estilista'];
  static const List<String> statuses = ['Activo', 'Inactivo'];

  String selectedFilterType = 'Estado';
  String selectedStatus = 'Activo';
  String? selectedStylist;

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openAddForm(
    BuildContext context,
    ServicesProvider provider,
  ) async {
    final ServiceModels? result = await NewServiceModal.show(context, provider);

    if (result == null || !context.mounted) return;
    provider.refresh();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryPurple,
        content: Text('Servicio ${result.serviceName} agregado exitosamente.'),
      ),
    );
  }

  void _openFilterModal(BuildContext context, ServicesProvider provider) {
    provider.ensureAllServicesLoaded();

    final stylists = provider.availableStylists;
    if (selectedStylist == null && stylists.isNotEmpty) {
      selectedStylist = stylists.first;
    }

    CustomFilterModal.show(
      context,
      title: 'Filtrar Servicios',
      builder: (modalContext, setModalState) {
        final currentStylists = provider.availableStylists;
        final currentStylistValue =
            (selectedStylist != null &&
                currentStylists.contains(selectedStylist))
            ? selectedStylist
            : (currentStylists.isNotEmpty ? currentStylists.first : null);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFilterDropdown(
              label: 'Filtrar por',
              value: selectedFilterType,
              items: filterTypes,
              onChanged: (val) {
                if (val != null) {
                  setModalState(() {
                    selectedFilterType = val;
                    if (selectedFilterType == 'Estilista' &&
                        selectedStylist == null &&
                        currentStylists.isNotEmpty) {
                      selectedStylist = currentStylists.first;
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            if (selectedFilterType == 'Estado')
              CustomFilterDropdown(
                label: 'Seleccionar Estado',
                value: selectedStatus,
                items: statuses,
                onChanged: (val) {
                  if (val != null) {
                    setModalState(() {
                      selectedStatus = val;
                    });
                  }
                },
              )
            else
              CustomFilterDropdown(
                label: 'Seleccionar Estilista',
                value: currentStylistValue,
                items: currentStylists.isNotEmpty
                    ? currentStylists
                    : const ['Sin estilistas disponibles'],
                onChanged: (val) {
                  if (val != null && val != 'Sin estilistas disponibles') {
                    setModalState(() {
                      selectedStylist = val;
                    });
                  }
                },
              ),
          ],
        );
      },
      onApply: () {
        _searchController.clear();
        if (selectedFilterType == 'Estado') {
          provider.setStatusFilter(selectedStatus == 'Activo');
        } else {
          if (selectedStylist != null &&
              selectedStylist != 'Sin estilistas disponibles') {
            provider.setStylistFilter(selectedStylist);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ServicesProvider>()..fetchServices(),
      child: Consumer<ServicesProvider>(
        builder: (context, provider, _) {
          final displayedServices = provider.filteredServices;

          final bool showSpinner =
              provider.services.isEmpty &&
              provider.viewStatus == ViewStatusService.loading;

          return Scaffold(
            backgroundColor: AppColors.bgtextColor,
            appBar: const AppHeader(title: 'Catálogo de Servicios'),
            body: SafeArea(
              child: CustomRefreshScrollView(
                onRefresh: provider.refresh,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                child: Column(
                  children: [
                    SearchBarAdd(
                      controller: _searchController,
                      onChanged: provider.search,
                      onAddPressed: () {
                        _openAddForm(context, provider);
                      },
                      onFilterPressed: () {
                        _openFilterModal(context, provider);
                      },
                    ),
                    const SizedBox(height: 12),

                    if (showSpinner)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      )
                    else if (provider.viewStatus == ViewStatusService.error &&
                        provider.services.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Column(
                          children: [
                            Text(
                              provider.errorMessage ??
                                  'Error al cargar los servicios',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: provider.refresh,
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      )
                    else if (provider.searchErrorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Column(
                          children: [
                            Text(
                              provider.searchErrorMessage!,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: provider.retrySearch,
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      )
                    else if (displayedServices.isEmpty)
                      const Center(child: Text('No se encontraron servicios.'))
                    else ...[
                      for (final item in displayedServices) ...[
                        ServiceCard(service: item),
                        const SizedBox(height: 12),
                      ],
                      if (!provider.isSearching &&
                          provider.selectedStatus == null &&
                          provider.selectedStylistFilter == null) ...[
                        CustomPagination(
                          currentPage: provider.currentPage,
                          totalPages: provider.totalPage,
                          onPageTap: (page) {
                            if (page != provider.currentPage) {
                              provider.fetchServices(pageNumber: page);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const CustomBottomNavBar(
              activeTab: 'Servicios',
            ),
          );
        },
      ),
    );
  }
}
