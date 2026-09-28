import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_date_filter.dart';
import '../../widgets/custom_modal_sheet.dart';
import '../../widgets/custom_pagination.dart';

import '../purchaseshistory/models/purchasesmodel.dart';

import 'widgets/purchaseshistory_card.dart';
import 'widgets/purchaseshistory_detail_modal.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgtextColor,

      appBar: const AppHeader(
        title: 'Historial de compras',
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

              PurchaseCard(
                purchase: const Purchase(
                  supplierName: 'Distribuidora Bella',
                  purchaseDate: '2026-09-27',
                  totalAmount: 1000.00,
                ),
                onViewDetail: () {
                  _mostrarDetalleCompra1(context);
                },
              ),

              const SizedBox(height: 12),

              PurchaseCard(
                purchase: const Purchase(
                  supplierName: 'Productos Salón',
                  purchaseDate: '2026-09-25',
                  totalAmount: 750.00,
                ),
                onViewDetail: () {
                  _mostrarDetalleCompra2(context);
                },
              ),

              const SizedBox(height: 12),

              PurchaseCard(
                purchase: const Purchase(
                  supplierName: 'Belleza Profesional',
                  purchaseDate: '2026-09-20',
                  totalAmount: 1200.00,
                ),
                onViewDetail: () {
                  _mostrarDetalleCompra3(context);
                },
              ),

              const SizedBox(height: 12),

              PurchaseCard(
                purchase: const Purchase(
                  supplierName: 'Distribuidora Central',
                  purchaseDate: '2026-09-15',
                  totalAmount: 625.00,
                ),
                onViewDetail: () {
                  _mostrarDetalleCompra4(context);
                },
              ),

              const SizedBox(height: 16),

              const CustomPagination(
                currentPage: 1,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const CustomBottomNavBar(
        activeTab: 'Compras',
      ),
    );
  }

  void _mostrarDetalleCompra1(BuildContext context) {
    const purchase = Purchase(
      supplierName: 'Distribuidora Bella',
      purchaseDate: '2026-09-27',
      totalAmount: 1000.00,
    );

    const details = [
      PurchaseDetail(
        productName: 'Sérum Verb',
        purchaseQuantity: 5,
        unitPrice: 125.00,
        lineTotal: 625.00,
      ),
      PurchaseDetail(
        productName: 'Shampoo Revitalizante',
        purchaseQuantity: 3,
        unitPrice: 125.00,
        lineTotal: 375.00,
      ),
    ];

    CustomModalSheet.show(
      context: context,
      child: const PurchaseDetailModal(
        purchase: purchase,
        details: details,
      ),
    );
  }

  void _mostrarDetalleCompra2(BuildContext context) {
    const purchase = Purchase(
      supplierName: 'Productos Salón',
      purchaseDate: '2026-09-25',
      totalAmount: 750.00,
    );

    const details = [
      PurchaseDetail(
        productName: 'Acondicionador Profesional',
        purchaseQuantity: 5,
        unitPrice: 100.00,
        lineTotal: 500.00,
      ),
      PurchaseDetail(
        productName: 'Mascarilla Capilar',
        purchaseQuantity: 2,
        unitPrice: 125.00,
        lineTotal: 250.00,
      ),
    ];

    CustomModalSheet.show(
      context: context,
      child: const PurchaseDetailModal(
        purchase: purchase,
        details: details,
      ),
    );
  }

  void _mostrarDetalleCompra3(BuildContext context) {
    const purchase = Purchase(
      supplierName: 'Belleza Profesional',
      purchaseDate: '2026-09-20',
      totalAmount: 1200.00,
    );

    const details = [
      PurchaseDetail(
        productName: 'Tratamiento Capilar',
        purchaseQuantity: 4,
        unitPrice: 200.00,
        lineTotal: 800.00,
      ),
      PurchaseDetail(
        productName: 'Aceite para Cabello',
        purchaseQuantity: 4,
        unitPrice: 100.00,
        lineTotal: 400.00,
      ),
    ];

    CustomModalSheet.show(
      context: context,
      child: const PurchaseDetailModal(
        purchase: purchase,
        details: details,
      ),
    );
  }

  void _mostrarDetalleCompra4(BuildContext context) {
    const purchase = Purchase(
      supplierName: 'Distribuidora Central',
      purchaseDate: '2026-09-15',
      totalAmount: 625.00,
    );

    const details = [
      PurchaseDetail(
        productName: 'Sérum Verb',
        purchaseQuantity: 5,
        unitPrice: 125.00,
        lineTotal: 625.00,
      ),
    ];

    CustomModalSheet.show(
      context: context,
      child: const PurchaseDetailModal(
        purchase: purchase,
        details: details,
      ),
    );
  }
}