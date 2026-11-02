import 'package:flutter/material.dart';
import 'package:gabel/presentation/screens/saleshistory/models/salesdetailmodel.dart';
import 'package:gabel/presentation/screens/saleshistory/models/salesmodel.dart';
import 'package:gabel/presentation/screens/saleshistory/widgets/saleshistory_card.dart';
import 'package:gabel/presentation/screens/saleshistory/widgets/saleshistory_detail_modal.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/custom_botton_navbar_sales.dart';
import '../../../widgets/custom_date_filter.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_pagination.dart';

import '../../purchaseshistory/models/purchasesmodel.dart';
import '../../purchaseshistory/widgets/purchaseshistory_card.dart';
import '../../purchaseshistory/widgets/purchaseshistory_detail_modal.dart';

class SalespersonScreen extends StatelessWidget {
  const SalespersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgtextColor,
      appBar: const AppHeader(
        title: 'Historial de ventas',
      ),
      bottomNavigationBar: const CustomBottomNavBarSales(
        activeTab: 'Ventas',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          child: Column(
            children: [
              const CustomDateFilter(),
              const SizedBox(height: 16),

              SalesCard(
                sale: const Sales(
                  customerName: 'Distribuidora Bella',
                  saleDate: '2026-09-27',
                  totalPrice: 1000.00,
                ),
                onViewDetail: () => _showDetail(
                  context,
                  customerName: 'Distribuidora Bella',
                  saleDate: '2026-09-27',
                  totalPrice: 1000.00,
                  details: const [
                    SaleDetail(
                      itemType: 'SERVICE',
                      productName: null,
                      serviceName: 'Lavado de cabello',
                      saleQuantity: 1,
                      salePrice: 150.00,
                      lineTotal: 150.00,
                    ),
                    SaleDetail(
                      itemType: 'SERVICE',
                      productName: null,
                      serviceName: 'Lavado de cabello',
                      saleQuantity: 1,
                      salePrice: 150.00,
                      lineTotal: 150.00,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              SalesCard(
                sale: const Sales(
                  customerName: 'Productos Salón',
                  saleDate: '2026-09-25',
                  totalPrice: 750.00,
                ),
                onViewDetail: () => _showDetail(
                  context,
                  customerName: 'Productos Salón',
                  saleDate: '2026-09-25',
                  totalPrice: 750.00,
                  details: const [
                    SaleDetail(
                      itemType: 'SERVICE',
                      productName: null,
                      serviceName: 'Lavado de cabello',
                      saleQuantity: 1,
                      salePrice: 150.00,
                      lineTotal: 150.00,
                    ),
                    SaleDetail(
                      itemType: 'SERVICE',
                      productName: null,
                      serviceName: 'Lavado de cabello',
                      saleQuantity: 1,
                      salePrice: 150.00,
                      lineTotal: 150.00,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              SalesCard(
                sale: const Sales(
                  customerName: 'Belleza Profesional',
                  saleDate: '2026-09-20',
                  totalPrice: 1200.00,
                ),
                onViewDetail: () => _showDetail(
                  context,
                  customerName: 'Belleza Profesional',
                  saleDate: '2026-09-20',
                  totalPrice: 1200.00,
                  details: [
                    SaleDetail(
                      itemType: 'SERVICE',
                      productName: null,
                      serviceName: 'Lavado de cabello',
                      saleQuantity: 1,
                      salePrice: 150.00,
                      lineTotal: 150.00,
                    ),
                    SaleDetail(
                      itemType: 'SERVICE',
                      productName: null,
                      serviceName: 'Lavado de cabello',
                      saleQuantity: 1,
                      salePrice: 150.00,
                      lineTotal: 150.00,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              SalesCard(
                sale: const Sales(
                  customerName: 'Distribuidora Central',
                  saleDate: '2026-09-15',
                  totalPrice: 625.00,
                ),
                onViewDetail: () => _showDetail(
                  context,
                  customerName: 'Distribuidora Central',
                  saleDate: '2026-09-15',
                  totalPrice: 625.00,
                  details: const [
                    SaleDetail(
                      itemType: 'SERVICE',
                      productName: null,
                      serviceName: 'Lavado de cabello',
                      saleQuantity: 1,
                      salePrice: 150.00,
                      lineTotal: 150.00,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const CustomPagination(currentPage: 1),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetail(
    BuildContext context, {
    required String customerName,
    required String saleDate,
    required double totalPrice,
    required List<SaleDetail> details,
  }) {
    CustomModalSheet.show(
      context: context,
      child: SalesDetailModal(
        sale: Sales(
          customerName: customerName,
          saleDate: saleDate,
          totalPrice: totalPrice,
        ),
        details: details,
      ),
    );
  }
}