import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'widgets/profile_info_row.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const AppHeader(
        title: 'Mi perfil',
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: AppColors.lightPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        size: 48,
                        color: AppColors.primaryPurple,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Vendedor',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Activo',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'INFORMACIÓN PERSONAL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textTertiary,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.borderGrey,
                  ),
                ),
                child: const Column(
                  children: [
                    ProfileInfoRow(
                      icon: Icons.person_outline,
                      label: 'Usuario',
                      value: 'Vendedor',
                    ),

                    Divider(
                      height: 30,
                      color: AppColors.borderGrey,
                    ),

                    ProfileInfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Cédula',
                      value: '0412910071003D',
                    ),

                    Divider(
                      height: 30,
                      color: AppColors.borderGrey,
                    ),

                    ProfileInfoRow(
                      icon: Icons.check_circle_outline,
                      label: 'Estado',
                      value: 'Activo',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              CustomButton(
                text: 'Editar perfil',
                icon: Icons.edit_outlined,
                onPressed: () {
                  // Próximo paso: EditProfileScreen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
