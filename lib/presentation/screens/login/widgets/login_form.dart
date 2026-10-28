import 'package:flutter/material.dart';
import 'package:gabel/presentation/providers/authenticatio_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login () async {
    if (!_formKey.currentState!.validate()) return;
    String usuario = _usuarioController.text.trim();
    String password = _passwordController.text.trim();

    await context.read<AuthenticationProvider>().login(
      username: usuario,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthenticationProvider>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
        CustomTextField(
          label: 'Usuario',
          hintText: 'Ingresa tu usuario',
          prefixIcon: Icons.person_outline,
          controller: _usuarioController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Ingresa tu usuario';
            }
            return null;
         },
        ),

        const SizedBox(height: 20),

        CustomTextField(
          label: 'Contraseña',
          hintText: 'Ingresa tu contraseña',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          controller: _passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa tu contraseña';
            }
            return null;
          },
        ),

        if (auth.errorMessage != null) ...[
          const SizedBox(height: 10),
          Text(
            auth.errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 17),
          ),
        ],
        const SizedBox(height: 26),

        CustomButton(
          text: 'Iniciar sesión',
          icon: Icons.login_rounded,
          onPressed: auth.isSubmitting ? null : _login
        ),
      ],
      ),
    );
  }
}