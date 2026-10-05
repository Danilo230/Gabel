import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import 'widgets/category_distribution_chart.dart';
import 'widgets/monthly_sales_chart.dart';
import 'widgets/stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const List<MonthlySale> _sales = [
    MonthlySale('Ene', 42),
    MonthlySale('Feb', 58),
    MonthlySale('Mar', 51),
    MonthlySale('Abr', 86),
    MonthlySale('May', 64),
    MonthlySale('Jun', 73),
  ];

  static const List<ProductCategory> _categories = [
    ProductCategory(
      name: 'Cabello',
      percentage: 45,
      color: AppColors.primaryPurple,
    ),
    ProductCategory(
      name: 'Insumos',
      percentage: 30,
      color: Color(0xFFA5329E),
    ),
    ProductCategory(
      name: 'Herramientas',
      percentage: 15,
      color: Color(0xFFE4D9F7),
    ),
    ProductCategory(
      name: 'Otros',
      percentage: 10,
      color: Color(0xFFE0E0E5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'Dashboard',
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.35,
              children: const [
                StatCard(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Total de Productos',
                  value: '1,248',
                ),
                StatCard(
                  icon: Icons.warning_amber_rounded,
                  label: 'Bajo stock',
                  value: '32',
                  style: StatStyle.danger,
                ),
                StatCard(
                  icon: Icons.delete_outline,
                  label: 'Productos dañados',
                  value: '5',
                  style: StatStyle.neutral,
                ),
                StatCard(
                  icon: Icons.content_cut_rounded,
                  label: 'Total de Servicios',
                  value: '156',
                ),
                StatCard(
                  icon: Icons.people_alt_outlined,
                  label: 'Total de Usuarios',
                  value: '42',
                ),
                StatCard(
                  icon: Icons.admin_panel_settings_outlined,
                  label: 'Total de Roles',
                  value: '4',
                  style: StatStyle.neutral,
                ),
              ],
            ),
            const SizedBox(height: 22),
            const MonthlySalesChart(data: _sales, highlightedMonth: 'Abr'),
            const SizedBox(height: 18),
            const CategoryDistributionChart(categories: _categories),
          ],
        ),
      ),
    );
  }
}
