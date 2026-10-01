import 'package:flutter/material.dart';
import '../models/servicemodels.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';

class ServiceDetailModal extends StatelessWidget {
  final Service service;

  const ServiceDetailModal({
    super.key,
    required this.service,
  });

  static void show(BuildContext context, {required Service service}) {
    CustomModalSheet.show(
      context: context,
      child: ServiceDetailModal(service: service),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle del Servicio',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailField(label: 'Nombre del servicio', value: service.name),
          const SizedBox(height: 14),

          _buildDetailField(label: 'Precio', value: service.price),
          const SizedBox(height: 14),

          _buildDetailField(label: 'Categoría', value: service.category),
          const SizedBox(height: 14),

          _buildDetailField(label: 'Descripción', value: service.description),
          const SizedBox(height: 14),

          _buildDetailField(label: 'Producto', value: service.product),
          const SizedBox(height: 14),

          _buildStatusField(label: 'Estado', status: service.status),
        ],
      ),
    );
  }

  Widget _buildDetailField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: AppColors.white, 
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderGrey),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusField({required String label, required String status}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.mediumPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}