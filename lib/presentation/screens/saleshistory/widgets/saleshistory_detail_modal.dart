import 'package:flutter/material.dart';
import 'package:gabel/core/utils/format_date.dart';
import 'package:gabel/data/models/sale_detail_model.dart';
import 'package:gabel/data/models/sale_with_details_model.dart';
import 'package:gabel/presentation/providers/sale_provider.dart';
import 'package:gabel/presentation/widgets/error_view.dart';
import 'package:gabel/presentation/widgets/loading_view.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';

class SalesDetailModal extends StatelessWidget {
  final SaleWithDetailsModel sale;

  const SalesDetailModal({
    super.key,
    required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de venta',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cliente',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sale.customerName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'C\$${sale.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            formatDate(sale.saleDate),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),

          const Divider(color: AppColors.borderGrey),

          const SizedBox(height: 14),

          const Text(
            'Productos y servicios',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 12),

          ...sale.details.map((detail) => _detalleItem(detail)),

          const SizedBox(height: 12),

          const Divider(color: AppColors.borderGrey),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total de la venta',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'C\$${sale.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _detalleItem(SaleDetailModel detail) {
    final bool esProducto = detail.productName != null;
    final String name = detail.productName ?? detail.serviceName ?? 'Sin nombre';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            esProducto ? 'Producto' : 'Servicio',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _datoDetalle('Cantidad', '${detail.saleQuantity}'),
              _datoDetalle(
                'Precio',
                'C\$${detail.salePrice.toStringAsFixed(2)}',
              ),
              _datoDetalle(
                'Subtotal',
                'C\$${detail.lineTotal.toStringAsFixed(2)}',
                destacar: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _datoDetalle(
    String titulo,
    String valor, {
    bool destacar = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          valor,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: destacar
                ? AppColors.primaryPurple
                : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class SalesDetailSheet extends StatelessWidget {
  const SalesDetailSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SaleProvider>();
    final sale = p.selectedSale;

    if (p.detailStatus == ViewStatusSale.success && sale != null) {
      return SalesDetailModal(sale: sale);
    }

    if (p.detailStatus == ViewStatusSale.error) {
      return CustomModalSheet(
        title: 'Detalle de venta',
        child: SizedBox(
          height: 220,
          child: ErrorView(
            errorMessage: p.detailErrorMessage ?? 'Error desconocido',
          ),
        ),
      );
    }

    return const CustomModalSheet(
      title: 'Detalle de venta',
      child: SizedBox(
        height: 220,
        child: LoadingView(message: 'Cargando detalle...'),
      ),
    );
  }
}