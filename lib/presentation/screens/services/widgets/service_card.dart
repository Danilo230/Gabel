import 'package:flutter/material.dart';
import 'package:gabel/data/models/service_models.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_delete.dart';
import 'edit_service_modal.dart';
import 'package:provider/provider.dart';
import 'package:gabel/presentation/providers/service_provider.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModels service;

  const ServiceCard({super.key, required this.service});

  Future<void> _deleteService(BuildContext context) async {
    final provider = context.read<ServicesProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const CustomDeleteDialog(
        message: '¿Estás seguro de que deseas eliminar este servicio?',
      ),
    );
    if (confirmed != true) return;
    final message = await provider.delete(service.serviceId);

    if (message != null) {
      await provider.refresh();
      messenger.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.deleteIcon,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            provider.errorMessage ?? 'Error al eliminar el servicio.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadowColor,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service.serviceName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Precio',
                    style: TextStyle(
                      color: AppColors.cardTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'C\$ ${service.servicePrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: service.serviceStatus
                          ? AppColors.lightGreen
                          : AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service.serviceStatus ? 'Activo' : 'Inactivo',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.visibility_outlined,
                          color: AppColors.actionIcon,
                          size: 20,
                        ),
                        onPressed: () {
                          EditServiceModal.show(context, service);
                        },
                      ),
                      const SizedBox(width: 14),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.deleteIcon,
                          size: 20,
                        ),
                        onPressed: () => _deleteService(context),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
