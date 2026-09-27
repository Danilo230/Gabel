import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Usuario',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          decoration: InputDecoration(
            hintText: 'Ingresa tu usuario',
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Color(0xFF7557AC),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Contraseña',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Ingresa tu contraseña',

            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF7557AC),
            ),

            suffixIcon: const Icon(
              Icons.visibility_outlined,
              color: Color(0xFF7557AC),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xFF7557AC),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Iniciar Sesión',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}