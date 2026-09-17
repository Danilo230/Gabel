import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String titulo;
  final List<Widget> opciones;

  const SettingsSection({
    super.key,
    required this.titulo,
    required this.opciones,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8E7AA8),
          ),
        ),

        const SizedBox(height: 8),

        // Tarjeta
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: _crearOpcionesConDivisores(),
          ),
        ),
      ],
    );
  }

  List<Widget> _crearOpcionesConDivisores() {
    List<Widget> elementos = [];

    for (int i = 0; i < opciones.length; i++) {
      elementos.add(opciones[i]);

      if (i < opciones.length - 1) {
        elementos.add(
          const Divider(height: 24),
        );
      }
    }

    return elementos;
  }
}