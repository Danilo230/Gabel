import 'package:flutter/material.dart';

import './widgets/app_routes.dart';

import 'screens/customers/customers.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/inventory/inventory.dart';
import 'screens/saleshistory/saleshistory.dart';
import 'screens/login/login.dart';
import 'screens/products/products.dart';
import 'screens/purchaseshistory/purchaseshistory.dart';
import 'screens/reports/reports.dart';
import 'screens/services/services.dart';
import 'screens/settings/settings.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.dashboard,

      routes: {
        AppRoutes.dashboard:
            (context) => const DashboardScreen(),

        AppRoutes.inventory:
            (context) => const InventoryScreen(),

        AppRoutes.purchaseHistory:
            (context) => const PurchaseHistoryScreen(),

        AppRoutes.saleHistory:
            (context) => const SalesScreen(),

        AppRoutes.products:
            (context) => const ProductsScreen(),

        AppRoutes.services:
            (context) => const ServicesScreen(),

       // AppRoutes.customers:
         //   (context) => const CustomersScreen(),

        //AppRoutes.reports:
          //  (context) => const ReportsScreen(),

        AppRoutes.settings:
            (context) => const SettingsScreen(),

        AppRoutes.login:
            (context) => const LoginScreen(),
      },
    );
  }
}
