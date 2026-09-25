import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenu;
  final Color backgroundColor;
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;

  const AppHeader({
    super.key,
    required this.title,
    this.showMenu = false,
    this.backgroundColor = Colors.white,
    this.onMenuTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      elevation: 0.5,
      centerTitle: showMenu,
      leading: showMenu
          ? IconButton(
              onPressed: onMenuTap,
              icon: const Icon(Icons.menu,
                  color: AppColors.textPrimary, size: 26),
            )
          : null,
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
              // Más adelante navegaremos al perfil
            },
            child: const Icon(
              Icons.account_circle_outlined,
              color: Color(0xFF424242),
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
