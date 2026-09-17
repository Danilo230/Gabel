import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(
            'assets/images/Logo.jpeg',
          ),
        ),

        SizedBox(height: 5),

        Text(
          'Gabel',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7557AC),
          ),
        ),

        SizedBox(height: 5),

        Text(
          'Bienvenido de nuevo',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7557AC),
          ),
        ),

        Text(
          'Ingresa tus credenciales para acceder',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}