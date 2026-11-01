import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/data/models/damaged_product_model.dart';
import 'package:gabel/data/models/inventory_model.dart';
import 'package:gabel/presentation/providers/inventory_provider.dart';
import 'package:gabel/presentation/providers/user_provider.dart' show ViewStatus;
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_modal_sheet.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/custom_refresh_scroll_view.dart';
import '../../widgets/custom_search_bar.dart';
import 'widgets/product_detail_modal.dart';
import 'widgets/product_inventory_card.dart';
import 'widgets/register_damage_modal.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  void _openDetail(
    BuildContext context,
    InventoryProvider inventory,
    InventoryModel item,
  ) {
    CustomModalSheet.show(
      context: context,
      child: ProductDetailModal(
        item: item,
        product: inventory.fetchProduct(item.productId),
      ),
    );
  }

  Future<void> _openDamageForm(
    BuildContext context,
    InventoryProvider inventory,
    InventoryModel item,
  ) async {
    final DamagedProductModel? result =
        await CustomModalSheet.show<DamagedProductModel>(
      context: context,
      child: RegisterDamageModal(item: item),
    );

    if (result == null || !context.mounted) return;

    inventory.refresh();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryPurple,
        content: Text(
          'Daño registrado correctamente para ${item.productName}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<InventoryProvider>()..fetchInventory(),
      child: Consumer<InventoryProvider>(
        builder: (context, inventory, _) {
          final bool showSpinner = inventory.items.isEmpty &&
              (inventory.viewStatus == ViewStatus.initial ||
                  inventory.viewStatus == ViewStatus.loading);

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: const AppHeader(
              title: 'Inventario',
            ),
            bottomNavigationBar:
                const CustomBottomNavBar(activeTab: 'Inventario'),
            body: SafeArea(
              child: CustomRefreshScrollView(
                onRefresh: inventory.refresh,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchBar(
                      hintText: 'Buscar productos...',
                      onChanged: inventory.search,
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
                    else if (inventory.viewStatus == ViewStatus.error)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Text(
                              inventory.errorMessage ??
                                  'Ocurrió un error inesperado.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: 'Reintentar',
                              onPressed: inventory.refresh,
                            ),
                          ],
                        ),
                      )
                    else if (inventory.items.isEmpty)
                      const Center(
                        child: Text(
                          'No se encontraron productos.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    else if (inventory.isSearching) ...[
                      if (inventory.isSearchLoading &&
                          inventory.filteredItems.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        )
                      else if (inventory.searchErrorMessage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Column(
                            children: [
                              Text(
                                inventory.searchErrorMessage!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CustomButton(
                                text: 'Reintentar',
                                onPressed: inventory.retrySearch,
                              ),
                            ],
                          ),
                        )
                      else if (inventory.filteredItems.isEmpty)
                        const Center(
                          child: Text(
                            'No se encontraron productos.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        )
                      else
                        for (final item in inventory.filteredItems)
                          ProductInventoryCard(
                            item: item,
                            onViewDetail: () =>
                                _openDetail(context, inventory, item),
                            onRegisterDamage: () =>
                                _openDamageForm(context, inventory, item),
                          ),
                    ] else ...[
                      for (final item in inventory.items)
                        ProductInventoryCard(
                          item: item,
                          onViewDetail: () =>
                              _openDetail(context, inventory, item),
                          onRegisterDamage: () =>
                              _openDamageForm(context, inventory, item),
                        ),
                      const SizedBox(height: 6),
                      Center(
                        child: CustomPagination(
                          currentPage: inventory.currentPage,
                          totalPages: inventory.totalPages,
                          onPageTap: (page) {
                            if (page != inventory.currentPage) {
                              inventory.fetchInventory(pageNumber: page);
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