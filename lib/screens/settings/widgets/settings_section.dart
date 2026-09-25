import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String qualification;
  final List<Widget> options;

  const SettingsSection({
    super.key,
    required this.qualification,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        Text(
          qualification,
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

    for (int i = 0; i < options.length; i++) {
      elementos.add(options[i]);

      if (i < options.length - 1) {
        elementos.add(
          const Divider(height: 24),
        );
      }
    }

    return elementos;
  }
}