import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../models/salesmodel.dart';  

class SalesDetailModal extends StatelessWidget {
  final Sales sale;

  const SalesDetailModal({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de venta',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                sale.customerName,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              Text(
                sale.saleDate,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                sale.totalPrice,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
}