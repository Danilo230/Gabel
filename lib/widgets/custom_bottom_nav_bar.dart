import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String pestanaActiva;

  const CustomBottomNavBar({
    super.key,
    this.pestanaActiva = 'Productos',
  });

  static const Color moradoPrincipal = Color(0xFF5C2483);

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
          _itemNavBar(Icons.grid_view_rounded, 'Dashboard'),
          _itemNavBar(Icons.inventory_2_outlined, 'Inventario'),
          _itemNavBar(Icons.sanitizer_outlined, 'Productos'),
          _itemNavBar(Icons.content_cut_rounded, 'Servicios'),
          _itemNavBar(Icons.show_chart_rounded, 'Reportes'),
        ],
      ),
    );
  }

  Widget _itemNavBar(IconData icono, String etiqueta) {
    final bool seleccionado = (etiqueta.toLowerCase() == pestanaActiva.toLowerCase());
    final Color color = seleccionado ? moradoPrincipal : const Color(0xFF2C2C2C);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icono, color: color, size: 22),
        const SizedBox(height: 3),
        Text(
          etiqueta,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: seleccionado ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
