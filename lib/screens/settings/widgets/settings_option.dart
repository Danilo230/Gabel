import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsOption({
    super.key,
    required this.icono,
    required this.titulo,
    required this.subtitulo,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            // Icono
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEFE8F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icono,
                color: const Color(0xFF5C2483),
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            // Título y subtítulo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitulo,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Elemento de la derecha
            trailing ??
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 22,
                ),
          ],
        ),
      ),
    );
  }
}