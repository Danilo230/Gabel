import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../theme/app_colors.dart';
import '../dashboard/widgets/category_distribution_chart.dart';
import '../dashboard/widgets/monthly_sales_chart.dart';
import '../../widgets/custom_date_filter.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

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
    ProductCategory(name: 'Insumos', percentage: 30, color: Color(0xFFA5329E)),
    ProductCategory(
      name: 'Herramientas',
      percentage: 15,
      color: Color(0xFFE4D9F7),
    ),
    ProductCategory(name: 'Otros', percentage: 10, color: Color(0xFFE0E0E5)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgtextColor,
      appBar: const AppHeader(title: 'Reportes'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: [
              const CustomDateFilter(),
              const SizedBox(height: 20),
              const MonthlySalesChart(data: _sales, highlightedMonth: 'Abr'),
              const SizedBox(height: 18),
              const CategoryDistributionChart(categories: _categories),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Más'),
    );
  }
}
