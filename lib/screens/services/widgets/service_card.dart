import 'package:flutter/material.dart';
import '../models/servicemodels.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_delete.dart';
import 'edit_service_modal.dart';
import 'service_detail_modal.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final String price;
  final IconData icon;

  const ServiceCard({
    super.key,
    required this.name,
    required this.price,
    this.icon = Icons.content_cut_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadowColor,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.bgIconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: AppColors.actionIcon,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Precio',
                    style: TextStyle(
                      color: AppColors.cardTextSecondary,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),

              Row(
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
                      ServiceDetailModal.show(
                        context,
                        service: Service(
                          name: name,
                          price: price,
                          category: 'Cuidado Capilar',
                          description: 'Servicio integral con lavado y peinado profesional.',
                          product: 'Shampoo Revitalizante, Acondicionador',
                          status: 'Activo',
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.actionIcon,
                      size: 20,
                    ),
                    onPressed: () {
                      EditServiceModal.show(context);
                    },
                  ),
                  const SizedBox(width: 16),

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.deleteIcon,
                      size: 20,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CustomDeleteDialog(
                          title: 'Eliminar',
                          message: '¿Deseas eliminar este servicio?',
                        ),
                      );
                    },
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