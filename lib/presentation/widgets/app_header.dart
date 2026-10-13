import 'package:flutter/material.dart';
import '../screens/settings/settings.dart';
import '../theme/app_colors.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const AppHeader({
    super.key,
    required this.title,
    this.backgroundColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      elevation: 0.5,
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryPurple,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            child: const Icon(
              Icons.account_circle_outlined,
              color: AppColors.textPrimary,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}