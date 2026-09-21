import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import 'widgets/report_search_bar.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FA),
      appBar: const AppHeader(titulo: 'Reportes'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: const [
              ReportSearchBar(),
              SizedBox(height: 12),
              CustomPagination(paginaActual: 3),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(pestanaActiva: 'Reportes'),
    );
  }
}
