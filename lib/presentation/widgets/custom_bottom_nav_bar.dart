import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../theme/app_palette.dart';
import 'more_options_modal.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String>? onItemTap;

  const CustomBottomNavBar({
    super.key,
    this.activeTab = 'Dashboard',
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(color: context.colors.border, width: 0.8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            context,
            Icons.grid_view_rounded,
            'Dashboard',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.dashboard,
                (route) => false,
              );
            },
          ),
          _navItem(
            context,
            Icons.inventory_2_outlined,
            'Inventario',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.inventory,
                (route) => false,
              );
            },
          ),
          _navItem(
            context,
            Icons.shopping_bag,
            'Compras',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.purchaseHistory,
                (route) => false,
              );
            },
          ),
          _navItem(
            context,
            Icons.shopping_cart,
            'Ventas',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.saleHistory,
                (route) => false,
              );
            },
          ),
          _navItem(
            context,
            Icons.more_horiz_rounded,
            'Más',
            onTap: () {
              MoreOptionsModal.show(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label, {
    VoidCallback? onTap,
  }) {
    final bool selected = label.toLowerCase() == activeTab.toLowerCase();

    final Color color = selected ? context.colors.primary : context.colors.icon;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap ?? (onItemTap == null ? null : () => onItemTap!(label)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}