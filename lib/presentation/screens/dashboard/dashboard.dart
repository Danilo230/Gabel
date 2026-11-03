import 'package:flutter/material.dart';
import 'package:gabel/core/constants/api_constants.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/error_view.dart';
import '../../widgets/power_bi_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String url = ApiConstants.instance.powerBiReportUrl;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppHeader(
        title: 'Dashboard',
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Dashboard'),
      body: SafeArea(
        child: url.isEmpty
            ? const ErrorView(
                errorMessage: 'Falta configurar POWER_BI_REPORT_URL en el archivo .env',
              )
            : PowerBiView(url: url),
      ),
    );
  }
}