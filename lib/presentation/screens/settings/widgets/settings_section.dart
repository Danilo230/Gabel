import 'package:flutter/material.dart';
import 'package:gabel/presentation/theme/app_palette.dart';

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
        Text(
          qualification,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: context.colors.sectionLabel,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: context.colors.shadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: _crearOpcionesConDivisores()),
        ),
      ],
    );
  }

  List<Widget> _crearOpcionesConDivisores() {
    final List<Widget> elementos = [];

    for (int i = 0; i < options.length; i++) {
      elementos.add(options[i]);

      if (i < options.length - 1) {
        elementos.add(const Divider(height: 24));
      }
    }

    return elementos;
  }
}