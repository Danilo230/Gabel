import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/presentation/providers/profile_provider.dart';
import 'package:gabel/presentation/widgets/custom_refresh_scroll_view.dart'; // ajusta al nombre real
import 'package:gabel/presentation/widgets/error_view.dart';
import 'package:gabel/presentation/widgets/loading_view.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import 'widgets/edit_profile_modal.dart';
import 'widgets/profile_info_row.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ProfileProvider>()..fetchProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  Widget _buildContent(BuildContext context, ProfileProvider p) {
    if (p.viewStatus == ViewStatusProfile.error) {
      return SizedBox(
        height: 320,
        child: ErrorView(
          errorMessage: p.errorMessage ?? 'Error desconocido',
          onRetry: p.refresh,
        ),
      );
    }

    final user = p.user;
    if (p.viewStatus != ViewStatusProfile.success || user == null) {
      return const SizedBox(
        height: 320,
        child: LoadingView(message: 'Cargando perfil...'),
      );
    }

    final role = user.roles.isEmpty ? 'Sin rol' : user.roles.join(', ');

    return Column(
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
              Text(
                user.userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  role,
                  style: const TextStyle(
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
            border: Border.all(color: AppColors.borderGrey),
          ),
          child: Column(
            children: [
              ProfileInfoRow(
                icon: Icons.person_outline,
                label: 'Usuario',
                value: user.userName,
              ),
              const Divider(height: 30, color: AppColors.borderGrey),
              ProfileInfoRow(
                icon: Icons.badge_outlined,
                label: 'Cédula',
                value: user.identityCard,
              ),
              const Divider(height: 30, color: AppColors.borderGrey),
              ProfileInfoRow(
                icon: Icons.shield_outlined,
                label: 'Rol',
                value: role,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        CustomButton(
          text: 'Editar perfil',
          icon: Icons.edit_outlined,
          onPressed: () => EditProfileModal.show(context, user),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: AppColors.bgtextColor,
      appBar: const AppHeader(title: 'Mi perfil'),
      body: SafeArea(
        child: CustomRefreshScrollView(
          onRefresh: provider.refresh,
          padding: const EdgeInsets.all(20),
          child: _buildContent(context, provider),
        ),
      ),
    );
  }
}