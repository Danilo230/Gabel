import 'package:flutter/material.dart';

import '../../../widgets/app_routes.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _iniciarSesion() {
    final String usuario =
        _usuarioController.text.trim().toLowerCase();

    if (usuario == 'admin') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.dashboard,
        (route) => false,
      );
    } else if (usuario == 'vendedor') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.salesperson,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario no válido'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Usuario',
          hintText: 'Ingresa tu usuario',
          prefixIcon: Icons.person_outline,
          controller: _usuarioController,
        ),

        const SizedBox(height: 20),

        CustomTextField(
          label: 'Contraseña',
          hintText: 'Ingresa tu contraseña',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          controller: _passwordController,
        ),

        const SizedBox(height: 26),

        CustomButton(
          text: 'Iniciar sesión',
          icon: Icons.login_rounded,
          onPressed: _iniciarSesion,
        ),
      ],
    );
  }
}