import 'package:flutter/material.dart';
import '../screens/settings/settings.dart';
import '../theme/app_palette.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;

  const AppHeader({
    super.key,
    required this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? context.colors.surface;

    return AppBar(
      backgroundColor: bg,
      surfaceTintColor: bg,
      elevation: 0.5,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          color: context.colors.primary,
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
            child: Icon(
              Icons.account_circle_outlined,
              color: context.colors.textPrimary,
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