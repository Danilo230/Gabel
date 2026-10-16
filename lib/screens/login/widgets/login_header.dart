import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const SizedBox(height: 30),

        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.lightPurple,
              width: 2,
            ),
          ),
          child: const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(
              'assets/images/Logo.jpeg',
            ),
          ),
        ),

        const SizedBox(height: 14),

        const Text(
          'Gabel',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryPurple,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'Bienvenido de nuevo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Ingresa tus credenciales para acceder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}