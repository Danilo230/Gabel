import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/custom_search_bar.dart';
import 'models/salesmodel.dart';
import '../../theme/app_colors.dart';
import 'widgets/saleshistory_card.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgtextColor,
      appBar: const AppHeader(title: 'Historial de ventas'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: const [
              CustomSearchBar(),
              SizedBox(height: 12),
              SalesCard(
                sale: Sales(
                  customerName: 'Juan',
                  saleDate: '2023-10-01',
                  totalPrice: 'C\$100.00',
                ),
              ),
              SizedBox(height: 12),
              SalesCard(
                sale: Sales(
                  customerName: 'María',
                  saleDate: '2023-10-02',
                  totalPrice: 'C\$150.00',
                ),
              ),
              SizedBox(height: 12),
              SalesCard(
                sale: Sales(
                  customerName: 'Carlos',
                  saleDate: '2023-10-03',
                  totalPrice: 'C\$200.00',
                ),
              ),
              SizedBox(height: 12),
              SalesCard(
                sale: Sales(
                  customerName: 'Ana',
                  saleDate: '2023-10-04',
                  totalPrice: 'C\$250.00',
                ),
              ),
              SizedBox(height: 12),
              CustomPagination(currentPage: 3),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Ventas'),
    );
  }
}