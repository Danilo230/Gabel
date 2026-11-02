import 'package:flutter/material.dart';
import 'package:gabel/presentation/screens/customers/widgets/customer_add_modal.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/search_bar_add.dart';
import 'package:gabel/data/models/customer_model.dart';
import '../../theme/app_colors.dart';
import 'widgets/customer_card.dart';
import '../../widgets/custom_refresh_scroll_view.dart';
import 'package:provider/provider.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/presentation/providers/customer_provider.dart';
import '../../widgets/custom_filter_dropdown.dart';
import '../../widgets/custom_filter_modal.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  static const List<String> statuses = ['Activo', 'Inactivo'];

  String selectedStatus = statuses.first;

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openAddForm(
    BuildContext context,
    CustomerProvider customer,
  ) async {
    final CustomerModel? result = await NewCustomerModal.show(
      context,
      customer,
    );

    if (result == null || !context.mounted) return;
    customer.refresh();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryPurple,
        content: Text('Cliente ${result.customerName} agregado exitosamente.'),
      ),
    );
  }

  void _openFilterModal(BuildContext context, CustomerProvider customer) {
    CustomFilterModal.show(
      context,
      title: 'Filtrar Clientes',
      builder: (modalContext, setModalState) {
        return CustomFilterDropdown(
          label: 'Estados',
          value: selectedStatus,
          items: statuses,
          onChanged: (val) {
            if (val != null) {
              setModalState(() {
                selectedStatus = val;
              });
            }
          },
        );
      },
      onApply: () {
        _searchController.clear();
        customer.setStatusFilter(selectedStatus == 'Activo');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<CustomerProvider>()..fetchCustomers(),
      child: Consumer<CustomerProvider>(
        builder: (context, customer, _) {
          final displayedCustomers = customer.filteredCustomers;

          final bool showSpinner =
              customer.customers.isEmpty &&
              customer.viewStatus == ViewStatusCustomer.loading;
          return Scaffold(
            backgroundColor: AppColors.bgtextColor,
            appBar: const AppHeader(title: 'Catálogo de Clientes'),
            body: SafeArea(
              child: CustomRefreshScrollView(
                onRefresh: customer.refresh,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                child: Column(
                  children: [
                    SearchBarAdd(
                      controller: _searchController,
                      onChanged: customer.search,
                      onAddPressed: () {
                        _openAddForm(context, customer);
                      },
                      onFilterPressed: () {
                        _openFilterModal(context, customer);
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
                    else if (customer.viewStatus == ViewStatusCustomer.error &&
                        customer.customers.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Column(
                          children: [
                            Text(
                              customer.errorMessage ??
                                  'Error al cargar los clientes',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: customer.refresh,
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      )
                    else if (customer.searchErrorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Column(
                          children: [
                            Text(
                              customer.searchErrorMessage!,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: customer.retrySearch,
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      )
                    else if (displayedCustomers.isEmpty)
                      const Center(child: Text('No se encontraron clientes.'))
                    else ...[
                      for (final item in displayedCustomers) ...[
                        CustomerCard(customer: item),
                        const SizedBox(height: 12),
                      ],
                      if (!customer.isSearching &&
                          customer.selectedStatus == null) ...[
                        CustomPagination(
                          currentPage: customer.currentPage,
                          totalPages: customer.totalPage,
                          onPageTap: (page) {
                            if (page != customer.currentPage) {
                              customer.fetchCustomers(pageNumber: page);
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
              activeTab: 'Clientes',
            ),
          );
        },
      ),
    );
  }
}
