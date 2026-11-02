import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import 'package:gabel/presentation/providers/user_provider.dart'
    show ViewStatus;
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/custom_refresh_scroll_view.dart';
import '../../widgets/search_bar_add.dart';
import 'widgets/product_modal.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = getIt<ProductProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          final bool showSpinner =
              provider.items.isEmpty &&
              (provider.viewStatus == ViewStatus.initial ||
                  provider.viewStatus == ViewStatus.loading);

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: const AppHeader(title: 'Productos'),
            bottomNavigationBar: const CustomBottomNavBar(
              activeTab: 'Productos',
            ),
            body: SafeArea(
              child: CustomRefreshScrollView(
                onRefresh: provider.refresh,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBarAdd(
                      onAddPressed: () => NewProductModal.show(context),
                      onFilterPressed: () {},
                    ),
                    const SizedBox(height: 18),

                    if (showSpinner)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      )
                    else if (provider.viewStatus == ViewStatus.error)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                provider.errorMessage ??
                                    'Ocurrió un error inesperado al cargar los productos.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (provider.items.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 48),
                          child: Text(
                            'No se encontraron productos registrados.',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    else ...[
                      Center(
                        child: CustomPagination(
                          currentPage: provider.currentPage,
                          totalPages: provider.totalPages,
                          onPageTap: (page) {
                            if (page != provider.currentPage) {
                              provider.fetchProducts(pageNumber: page);
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
