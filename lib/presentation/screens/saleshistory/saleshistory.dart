
import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/core/utils/format_date.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import 'package:gabel/presentation/providers/sale_provider.dart';
import 'package:gabel/presentation/providers/service_provider.dart';
import 'package:gabel/presentation/widgets/custom_filter_modal.dart';
import 'package:gabel/presentation/widgets/custom_refresh_scroll_view.dart';
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

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late final SaleProvider _saleProvider;
  late final ProductProvider _productProvider;
  late final ServicesProvider _servicesProvider;

  @override
  void initState() {
    super.initState();

    _saleProvider = getIt<SaleProvider>();
    _productProvider = getIt<ProductProvider>();
    _servicesProvider = getIt<ServicesProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _saleProvider.fetchSales();
      _productProvider.fetchProducts();
      _servicesProvider.fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _saleProvider),
        ChangeNotifierProvider.value(value: _productProvider),
        ChangeNotifierProvider.value(value: _servicesProvider),
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

  static const String _allProducts = 'Todos los productos';
  static const String _allServices = 'Todos los servicios';

  String selectedProduct = _allProducts;
  String selectedService = _allServices;

  void _openFilterModal() {
    final productProvider = context.read<ProductProvider>();
    final servicesProvider = context.read<ServicesProvider>();

    debugPrint('ESTADO SERVICIOS: ${servicesProvider.viewStatus}');
    debugPrint('CANTIDAD SERVICIOS: ${servicesProvider.items.length}');
    debugPrint('ERROR SERVICIOS: ${servicesProvider.errorMessage}');

    final productItems = [
      _allProducts,
      ...productProvider.items.map((product) => product.productName),
    ];

    final serviceItems = [
      _allServices,
      ...servicesProvider.items.map((service) => service.serviceName),
    ];

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
              items: productItems,
              onChanged: (val) {
                if (val == null) return;

                setModalState(() {
                  selectedProduct = val;

                  if (val != _allProducts) {
                    selectedService = _allServices;
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            CustomFilterDropdown(
              label: 'Servicios',
              value: selectedService,
              items: serviceItems,
              onChanged: (val) {
                if (val == null) return;

                setModalState(() {
                  selectedService = val;

                  if (val != _allServices) {
                    selectedProduct = _allProducts;
                  }
                });
              },
            ),
          ],
        );
      },
      onApply: () {
        if (selectedProduct != _allProducts) {
          for (final product in productProvider.items) {
            if (product.productName == selectedProduct) {
              setState(() {
                _startDate = null;
                _endDate = null;
              });

              context.read<SaleProvider>().filterByProduct(
                    product.productId,
                  );
              return;
            }
          }
        }

        if (selectedService != _allServices) {
          for (final service in servicesProvider.items) {
            if (service.serviceName == selectedService) {
              setState(() {
                _startDate = null;
                _endDate = null;
              });

              context.read<SaleProvider>().filterByService(
                    service.serviceId,
                  );
              return;
            }
          }
        }

        context.read<SaleProvider>().clearFilter();
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

    if (start == null || end == null) return;

    if (start.isAfter(end)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'La fecha de inicio no puede ser mayor que la de fin',
          ),
        ),
      );
      return;
    }

    selectedProduct = _allProducts;
    selectedService = _allServices;

    context.read<SaleProvider>().filterByDateRange(start, end);
  }

  void _clearFilter() {
    setState(() {
      _startDate = null;
      _endDate = null;
      selectedProduct = _allProducts;
      selectedService = _allServices;
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          child: Column(
            children: [
              CustomDateFilter(
                startDate: _startDate == null
                    ? 'Fecha inicial'
                    : formatDate(_startDate!),
                endDate: _endDate == null
                    ? 'Fecha final'
                    : formatDate(_endDate!),
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
      bottomNavigationBar: const CustomBottomNavBar(
        activeTab: 'Ventas',
      ),
    );
  }
}
