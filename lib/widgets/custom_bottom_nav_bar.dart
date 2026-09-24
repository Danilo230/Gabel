import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String>? onItemTap;

  const CustomBottomNavBar({
    super.key,
    this.activeTab = 'Productos',
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.grid_view_rounded, 'Dashboard'),
          _navItem(Icons.inventory_2_outlined, 'Inventario'),
          _navItem(Icons.sanitizer_outlined, 'Productos'),
          _navItem(Icons.content_cut_rounded, 'Servicios'),
          _navItem(Icons.show_chart_rounded, 'Reportes'),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label) {
    final bool selected = label.toLowerCase() == activeTab.toLowerCase();
    final Color color =
        selected ? AppColors.primaryPurple : const Color(0xFF2C2C2C);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onItemTap == null ? null : () => onItemTap!(label),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
