import 'package:flutter/material.dart';
import 'package:gabel/presentation/widgets/custom_filter_modal.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_date_filter.dart';
import '../../widgets/custom_filter_dropdown.dart';
import '../../widgets/custom_modal_sheet.dart';
import '../../widgets/custom_pagination.dart';

import 'models/salesmodel.dart';
import 'models/salesdetailmodel.dart';
import 'widgets/saleshistory_card.dart';
import 'widgets/saleshistory_detail_modal.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {

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
                if (val != null) {
                  setModalState(() => selectedProduct = val);
                }
              },
            ),
            const SizedBox(height: 16),
            CustomFilterDropdown(
              label: 'Servicios',
              value: selectedService,
              items: services,
              onChanged: (val){
                if(val != null){
                  setModalState(() => selectedService = val);
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

  Future<void> _selectStartDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
  }

  Future<void> _selectEndDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgtextColor,

      appBar: const AppHeader(
        title: 'Historial de ventas',
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          child: Column(
            children: [

              CustomDateFilter(
                onStartDateTap: () => _selectStartDate(context),
                onEndDateTap: () => _selectEndDate(context),
                onFilterPressed: _openFilterModal,
              ),

              const SizedBox(height: 16),

              SalesCard(
                sale: const Sales(
                  customerName: 'Juan',
                  saleDate: '2023-10-01',
                  totalPrice: 500.00,
                ),
                onViewDetail: () {
                  _mostrarDetalleJuan(context);
                },
              ),

              const SizedBox(height: 12),

              SalesCard(
                sale: const Sales(
                  customerName: 'María',
                  saleDate: '2023-10-02',
                  totalPrice: 150.00,
                ),
                onViewDetail: () {
                  _mostrarDetalleMaria(context);
                },
              ),

              const SizedBox(height: 12),

              SalesCard(
                sale: const Sales(
                  customerName: 'Carlos',
                  saleDate: '2023-10-03',
                  totalPrice: 200.00,
                ),
                onViewDetail: () {
                  _mostrarDetalleCarlos(context);
                },
              ),

              const SizedBox(height: 12),

              SalesCard(
                sale: const Sales(
                  customerName: 'Ana',
                  saleDate: '2023-10-04',
                  totalPrice: 250.00,
                ),
                onViewDetail: () {
                  _mostrarDetalleAna(context);
                },
              ),

              const SizedBox(height: 12),

              const CustomPagination(
                currentPage: 3,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const CustomBottomNavBar(
        activeTab: 'Ventas',
      ),
    );
  }

  void _mostrarDetalleJuan(BuildContext context) {
    const sale = Sales(
      customerName: 'Juan',
      saleDate: '2023-10-01',
      totalPrice: 500.00,
    );

    const details = [
      SaleDetail(
        itemType: 'PRODUCT',
        productName: 'Shampoo Revitalizante',
        serviceName: null,
        saleQuantity: 2,
        salePrice: 150.00,
        lineTotal: 300.00,
      ),
      SaleDetail(
        itemType: 'SERVICE',
        productName: null,
        serviceName: 'Corte de cabello',
        saleQuantity: 1,
        salePrice: 200.00,
        lineTotal: 200.00,
      ),
    ];

    CustomModalSheet.show(
      context: context,
      child: const SalesDetailModal(
        sale: sale,
        details: details,
      ),
    );
  }

  void _mostrarDetalleMaria(BuildContext context) {
    const sale = Sales(
      customerName: 'María',
      saleDate: '2023-10-02',
      totalPrice: 150.00,
    );

    const details = [
      SaleDetail(
        itemType: 'SERVICE',
        productName: null,
        serviceName: 'Lavado de cabello',
        saleQuantity: 1,
        salePrice: 150.00,
        lineTotal: 150.00,
      ),
    ];

    CustomModalSheet.show(
      context: context,
      child: const SalesDetailModal(
        sale: sale,
        details: details,
      ),
    );
  }

  void _mostrarDetalleCarlos(BuildContext context) {
    const sale = Sales(
      customerName: 'Carlos',
      saleDate: '2023-10-03',
      totalPrice: 200.00,
    );

    const details = [
      SaleDetail(
        itemType: 'PRODUCT',
        productName: 'Acondicionador',
        serviceName: null,
        saleQuantity: 1,
        salePrice: 200.00,
        lineTotal: 200.00,
      ),
    ];

    CustomModalSheet.show(
      context: context,
      child: const SalesDetailModal(
        sale: sale,
        details: details,
      ),
    );
  }

  void _mostrarDetalleAna(BuildContext context) {
    const sale = Sales(
      customerName: 'Ana',
      saleDate: '2023-10-04',
      totalPrice: 250.00,
    );

    const details = [
      SaleDetail(
        itemType: 'SERVICE',
        productName: null,
        serviceName: 'Tratamiento capilar',
        saleQuantity: 1,
        salePrice: 250.00,
        lineTotal: 250.00,
      ),
    ];

    CustomModalSheet.show(
      context: context,
      child: const SalesDetailModal(
        sale: sale,
        details: details,
      ),
    );
  }
}