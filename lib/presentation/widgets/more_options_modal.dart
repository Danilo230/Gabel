import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../theme/app_colors.dart';
import 'custom_modal_sheet.dart';

class MoreOptionsModal extends StatelessWidget {
  const MoreOptionsModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(context: context, child: const MoreOptionsModal());
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Más opciones',
      child: Column(
        children: [
          _option(
            icon: Icons.sanitizer_outlined,
            title: 'Productos',
            subtitle: 'Catálogo de productos',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.products.toString(),
                (route) => false,
              );
            },
          ),

          const SizedBox(height: 10),

          _option(
            icon: Icons.content_cut_rounded,
            title: 'Servicios',
            subtitle: 'Catálogo de servicios',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.services.toString(),
                (route) => false,
              );
            },
          ),

          const SizedBox(height: 10),

          _option(
            icon: Icons.people_outline_rounded,
            title: 'Clientes',
            subtitle: 'Catálogo de clientes',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.customers.toString(),
                (route) => false,
              );
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _option({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.BlackIcon, size: 23),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.iconGrey,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
