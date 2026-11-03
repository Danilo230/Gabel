import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_filter_dropdown.dart';
import '../../widgets/custom_filter_modal.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/custom_refresh_scroll_view.dart';
import '../../widgets/search_bar_add.dart';
import 'widgets/product_card.dart';
import 'widgets/product_modal.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
    ProductProvider provider,
  ) async {
    final ProductModel? result = await NewProductModal.show(context, provider);

    if (result == null || !context.mounted) return;
    provider.refresh();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryPurple,
        content: Text('Producto ${result.productName} agregado exitosamente.'),
      ),
    );
  }

  void _openFilterModal(BuildContext context, ProductProvider provider) {
    CustomFilterModal.show(
      context,
      title: 'Filtrar Productos',
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
        provider.setStatusFilter(selectedStatus == 'Activo');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<ProductProvider>()..fetchProducts(),
      child: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          final displayedProducts = provider.filteredProducts;

          final bool showSpinner =
              provider.products.isEmpty &&
              provider.viewStatus == ViewStatusProduct.loading;

          return Scaffold(
            backgroundColor: AppColors.bgtextColor,
            appBar: const AppHeader(title: 'Catálogo de Productos'),
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
                    else if (provider.viewStatus == ViewStatusProduct.error &&
                        provider.products.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Column(
                          children: [
                            Text(
                              provider.errorMessage ??
                                  'Error al cargar los productos',
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
                    else if (displayedProducts.isEmpty)
                      const Center(child: Text('No se encontraron productos.'))
                    else ...[
                      for (final item in displayedProducts) ...[
                        ProductCard(product: item),
                        const SizedBox(height: 12),
                      ],
                      if (!provider.isSearching &&
                          provider.selectedStatus == null) ...[
                        CustomPagination(
                          currentPage: provider.currentPage,
                          totalPages: provider.totalPage,
                          onPageTap: (page) {
                            if (page != provider.currentPage) {
                              provider.fetchProducts(pageNumber: page);
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
              activeTab: 'Productos',
            ),
          );
        },
      ),
    );
  }
}
