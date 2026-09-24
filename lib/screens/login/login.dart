import 'package:flutter/material.dart';

import 'widgets/login_header.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            children: const [
              LoginHeader(),

              SizedBox(height: 47),

              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}