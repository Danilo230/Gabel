import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/core/utils/format_date.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import 'package:gabel/presentation/providers/purchase_provider.dart';
import 'package:gabel/presentation/widgets/custom_filter_modal.dart';
import 'package:gabel/presentation/widgets/custom_refresh_scroll_view.dart'; // ajusta al nombre real del archivo
import 'package:gabel/presentation/widgets/error_view.dart';
import 'package:gabel/presentation/widgets/loading_view.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_date_filter.dart';
import '../../widgets/custom_filter_dropdown.dart';
import '../../widgets/custom_modal_sheet.dart';
import '../../widgets/custom_pagination.dart';
import 'package:gabel/presentation/providers/supplier_provider.dart';
import 'widgets/purchaseshistory_card.dart';
import 'widgets/purchaseshistory_detail_modal.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});
    
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<PurchaseProvider>()..fetchPurchases(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<SupplierProvider>()..fetchSuppliers(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<ProductProvider>()..fetchProducts(),
        ),
      ],
      child: const _PurchaseHistoryView(),
    );
  }
}

class _PurchaseHistoryView extends StatefulWidget {
  const _PurchaseHistoryView();

  @override
  State<_PurchaseHistoryView> createState() => _PurchaseHistoryViewState();
}

class _PurchaseHistoryViewState extends State<_PurchaseHistoryView> {
  DateTime? _startDate;
  DateTime? _endDate;

  String selectedProduct = 'Todos los productos';

  String selectedSupplier = 'Todos los proveedores';


 
  void _openFilterModal() {
    final supplierProvider = context.read<SupplierProvider>();
    final productProvider = context.read<ProductProvider>();

    CustomFilterModal.show(
      context,
      title: 'Filtrar Compras',
      builder: (modalContext, setModalState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFilterDropdown(
              label: 'Productos',
              value: selectedProduct,
              items: [
                'Todos los productos',
                ...productProvider.items.map(
                  (product) => product.productName,
                ),
              ],
              onChanged: (val) {
                if (val != null) {
                  setModalState(() => selectedProduct = val);
                }
              },
            ),
            const SizedBox(height: 16),
            CustomFilterDropdown(
              label: 'Proveedores',
              value: selectedSupplier,
              items: [
                'Todos los proveedores',
                ...supplierProvider.suppliers.map(
                  (supplier) => supplier.supplierName,
                ),
              ],
              onChanged: (val) {
                if (val != null) {
                  setModalState(() => selectedSupplier = val);
                }
              },
            ),
          ],
        );
      },
      onApply: () {
        final purchaseProvider = context.read<PurchaseProvider>();

        setState(() {
          _startDate = null;
          _endDate = null;
        });

        if (selectedProduct != 'Todos los productos') {
          final product = productProvider.items.firstWhere(
            (product) => product.productName == selectedProduct,
          );

          purchaseProvider.filterByProduct(product.productId!);
          return;
        }

        if (selectedSupplier != 'Todos los proveedores') {
          final supplier = supplierProvider.suppliers.firstWhere(
            (supplier) => supplier.supplierName == selectedSupplier,
          );

          purchaseProvider.filterBySupplier(supplier.supplierId);
          return;
        }
        purchaseProvider.clearFilter();
      },
    );
  }


  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked == null || !mounted) return;
    _startDate = picked;
    _applyDateFilter();
    setState(() => _startDate = picked);
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked == null || !mounted) return;
    _endDate = picked;
    _applyDateFilter();
    setState(() => _endDate = picked);
  }

  void _applyDateFilter() {
    final start = _startDate;
    final end = _endDate;
    if (start == null || end == null) return; 

    if (start.isAfter(end)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La fecha de inicio no puede ser mayor que la de fin'),
        ),
      );
      return;
    }
    context.read<PurchaseProvider>().filterByDateRange(start, end);
  }

  void _clearFilter() {
    setState(() {
      _startDate = null;
      _endDate = null;
    });
    context.read<PurchaseProvider>().clearFilter();
  }

  void _showDetail(int purchaseId) {
    final provider = context.read<PurchaseProvider>();
    provider.fetchPurchaseDetail(purchaseId);

    CustomModalSheet.show(
      context: context,
      child: ChangeNotifierProvider.value(
        value: provider,
        child: const PurchaseDetailSheet(),
      ),
    );
  }

  Widget _buildContent(PurchaseProvider p) {
    if (p.viewStatus == ViewStatusPurchase.error) {
      return SizedBox(
        height: 320,
        child: ErrorView(
          errorMessage: p.errorMessage ?? 'Error desconocido',
          onRetry: p.refresh,
        ),
      );
    }

    if (p.viewStatus != ViewStatusPurchase.success) {
      return const SizedBox(
        height: 320,
        child: LoadingView(message: 'Cargando compras...'),
      );
    }

    if (p.purchases.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No hay compras')),
      );
    }

    return Column(
      children: [
        for (final purchase in p.purchases) ...[
          PurchaseCard(
            purchase: purchase,
            onViewDetail: () => _showDetail(purchase.purchaseId),
          ),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 4),
        CustomPagination(currentPage: p.currentPage,totalPages: p.totalPages,onPageTap: (page) => p.fetchPurchases(pageNumber: page),),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PurchaseProvider>();

    return Scaffold(
      backgroundColor: AppColors.bgtextColor,
      appBar: const AppHeader(title: 'Historial de compras'),
      body: SafeArea(
        child: CustomRefreshScrollView(
          onRefresh: provider.refresh,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: [
              CustomDateFilter(
                startDate: _startDate == null ? 'Fecha inicial' : formatDate(_startDate!),
                endDate: _endDate == null ? 'Fecha final' : formatDate(_endDate!),
                onStartDateTap: _selectStartDate,
                onEndDateTap: _selectEndDate,
                onFilterPressed: _openFilterModal,
              ),
              if (provider.isFiltering)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _clearFilter,
                    icon: const Icon(Icons.close),
                    label: const Text('Quitar filtro'),
                  ),
                ),
              const SizedBox(height: 16),
              _buildContent(provider),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Compras'),
    );
  }
}