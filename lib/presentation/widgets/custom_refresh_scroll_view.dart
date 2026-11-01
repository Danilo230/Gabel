import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// contenedor con scroll que permite recargar los datos al deslizar hacia abajo

class CustomRefreshScrollView extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CustomRefreshScrollView({
    super.key,
    required this.onRefresh,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primaryPurple,
      backgroundColor: AppColors.white,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: padding,
        child: child,
      ),
    );
  }
}