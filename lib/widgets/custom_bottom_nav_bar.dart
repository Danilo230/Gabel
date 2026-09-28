import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../theme/app_colors.dart';
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
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            Icons.grid_view_rounded,
            'Dashboard',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard.toString(), (route) => false);
            },
          ),

          _navItem(
            Icons.inventory_2_outlined,
            'Inventario',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.inventory.toString(), (route) => false);
            },
          ),

          _navItem(
            Icons.shopping_cart_outlined,
            'Compras',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.purchaseHistory.toString(), (route) => false);
            },
          ),

          _navItem(
            Icons.receipt_long_outlined,
            'Ventas',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.saleHistory.toString(), (route) => false);
            },
          ),

          _navItem(
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
    IconData icon,
    String label, {
    VoidCallback? onTap,
  }) {
    final bool selected =
        label.toLowerCase() == activeTab.toLowerCase();

    final Color color = selected
        ? AppColors.primaryPurple
        : const Color(0xFF2C2C2C);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,

        onTap: onTap ??
            (onItemTap == null
                ? null
                : () => onItemTap!(label)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 22,
            ),

            const SizedBox(height: 3),

            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight:
                    selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}