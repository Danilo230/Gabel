import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../models/salesmodel.dart';
import '../models/salesdetailmodel.dart';

class SalesDetailModal extends StatelessWidget {
  final Sales sale;
  final List<SaleDetail> details;

  const SalesDetailModal({
    super.key,
    required this.sale,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de venta',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Información general de la venta
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                color: AppColors.primaryPurple,
                size: 22,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  sale.customerName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              Text(
                sale.totalPrice,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 17,
                color: AppColors.textSecondary,
              ),

              const SizedBox(width: 8),

              Text(
                sale.saleDate,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Divider(
            color: AppColors.borderGrey,
          ),

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

          // Detalles de la venta
          ...details.map(
            (detail) => _detalleItem(detail),
          ),

          const SizedBox(height: 12),

          const Divider(
            color: AppColors.borderGrey,
          ),

          const SizedBox(height: 12),

          // Total
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
                sale.totalPrice,
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

  Widget _detalleItem(SaleDetail detail) {
    final bool esProducto = detail.itemType == 'PRODUCT';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderGrey,
        ),
      ),

      child: Column(
        children: [

          Row(
            children: [

              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.paleLavender,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Icon(
                  esProducto
                      ? Icons.shopping_bag_outlined
                      : Icons.content_cut_rounded,
                  color: AppColors.primaryPurple,
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      detail.itemName,
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
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _datoDetalle(
                'Cantidad',
                '${detail.saleQuantity}',
              ),

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