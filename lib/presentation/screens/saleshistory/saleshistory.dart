import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/core/utils/format_date.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import 'package:gabel/presentation/providers/sale_provider.dart';
import 'package:gabel/presentation/providers/service_provider.dart';
import 'package:gabel/presentation/widgets/custom_filter_modal.dart';
import 'package:gabel/presentation/widgets/custom_refresh_scroll_view.dart'; // ajusta al nombre real
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

import 'widgets/saleshistory_card.dart';
import 'widgets/saleshistory_detail_modal.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<SaleProvider>()..fetchSales(),
        ),
        ChangeNotifierProvider.value(
          value: getIt<ProductProvider>()..fetchProducts(),
        ),
        ChangeNotifierProvider.value(
          value: getIt<ServicesProvider>()..fetchServices(),
        ),
      ],
      child: const _SalesView(),
    );
  }
}

class _SalesView extends StatefulWidget {
  const _SalesView();

  @override
  State<_SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<_SalesView> {
  DateTime? _startDate;
  DateTime? _endDate;

  static const List<String> products = [
    'Todos los productos',
    'Shampoo Revitalizante',
    'Acondicionador',
  ];
  String selectedProduct = products.first;

  static const List<String> services = [
    'Todos los servicios',
    'Corte de cabello',
    'Lavado de cabello',
    'Tratamiento capilar',
  ];
  String selectedService = services.first;

  void _openFilterModal() {
    CustomFilterModal.show(
      context,
      title: 'Filtrar Ventas',
      builder: (modalContext, setModalState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFilterDropdown(
              label: 'Productos',
              value: selectedProduct,
              items: products,
              onChanged: (val) {
                if (val != null) setModalState(() => selectedProduct = val);
              },
            ),
            const SizedBox(height: 16),
            CustomFilterDropdown(
              label: 'Servicios',
              value: selectedService,
              items: services,
              onChanged: (val) {
                if (val != null) setModalState(() => selectedService = val);
              },
            ),
          ],
        );
      },
      onApply: () => setState(() {}),
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
    setState(() => _startDate = picked);
    _applyDateFilter();
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked == null || !mounted) return;
    setState(() => _endDate = picked);
    _applyDateFilter();
  }

  void _applyDateFilter() {
    final start = _startDate;
    final end = _endDate;
    if (start == null || end == null) return; // espera a tener las dos

    if (start.isAfter(end)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La fecha de inicio no puede ser mayor que la de fin'),
        ),
      );
      return;
    }
    context.read<SaleProvider>().filterByDateRange(start, end);
  }

  void _clearFilter() {
    setState(() {
      _startDate = null;
      _endDate = null;
    });
    context.read<SaleProvider>().clearFilter();
  }

  void _showDetail(int saleId) {
    final provider = context.read<SaleProvider>();
    provider.fetchSaleDetail(saleId);

    CustomModalSheet.show(
      context: context,
      child: ChangeNotifierProvider.value(
        value: provider,
        child: const SalesDetailSheet(),
      ),
    );
  }

  Widget _buildContent(SaleProvider p) {
    if (p.viewStatus == ViewStatusSale.error) {
      return SizedBox(
        height: 320,
        child: ErrorView(
          errorMessage: p.errorMessage ?? 'Error desconocido',
          onRetry: p.refresh,
        ),
      );
    }

    if (p.viewStatus != ViewStatusSale.success) {
      return const SizedBox(
        height: 320,
        child: LoadingView(message: 'Cargando ventas...'),
      );
    }

    if (p.sales.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No hay ventas')),
      );
    }

    return Column(
      children: [
        for (final sale in p.sales) ...[
          SalesCard(
            sale: sale,
            onViewDetail: () => _showDetail(sale.saleId),
          ),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 4),
        CustomPagination(
          currentPage: p.currentPage,
          totalPages: p.totalPages,
          onPageTap: (page) => p.fetchSales(pageNumber: page),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SaleProvider>();

    return Scaffold(
      backgroundColor: AppColors.bgtextColor,
      appBar: const AppHeader(title: 'Historial de ventas'),
      body: SafeArea(
        child: CustomRefreshScrollView(
          onRefresh: provider.refresh,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: [
              CustomDateFilter(
                startDate:
                    _startDate == null ? 'Fecha inicial' : formatDate(_startDate!),
                endDate:
                    _endDate == null ? 'Fecha final' : formatDate(_endDate!),
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
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Ventas'),
    );
  }
}