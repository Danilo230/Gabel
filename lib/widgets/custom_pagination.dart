import 'package:flutter/material.dart';

class CustomPagination extends StatelessWidget {
  final int paginaActual;
  final int totalPaginas;

  const CustomPagination({
    super.key,
    this.paginaActual = 6,
    this.totalPaginas = 7,
  });

  static const Color moradoPrincipal = Color(0xFF5C2483);
  static const Color moradoOscuro = Color(0xFF451566);
  static const Color moradoPaginacionActiva = Color(0xFF853BAF);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: moradoPrincipal,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _botonFlecha(Icons.chevron_left),
          const SizedBox(width: 4),
          for (int i = 1; i <= totalPaginas; i++)
            _numeroPagina(i.toString(), activa: (i == paginaActual)),
          const SizedBox(width: 4),
          _botonFlecha(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _numeroPagina(String numero, {bool activa = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: activa ? moradoPaginacionActiva : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        numero,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: activa ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _botonFlecha(IconData icono) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: moradoOscuro,
      ),
      child: Icon(icono, color: Colors.white, size: 18),
    );
  }
}
