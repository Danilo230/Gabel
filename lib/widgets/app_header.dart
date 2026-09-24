import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const AppHeader({
    super.key,
    required this.titulo,
  });

  static const Color moradoPrincipal = Color(0xFF5C2483);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: Text(
        titulo,
        style: const TextStyle(
          color: moradoPrincipal,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.account_circle_outlined,
            color: Color(0xFF424242),
            size: 28,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
