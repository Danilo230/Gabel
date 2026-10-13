import 'package:flutter/material.dart';

import 'presentation/widgets/app_routes.dart';

<<<<<<< HEAD
import 'screens/customers/customers.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/salesperson/widget/salesperson.dart';
import 'screens/inventory/inventory.dart';
import 'screens/saleshistory/saleshistory.dart';
import 'screens/login/login.dart';
import 'screens/products/products.dart';
import 'screens/purchaseshistory/purchaseshistory.dart';
import 'screens/reports/reports.dart';
import 'screens/services/services.dart';
import 'screens/settings/settings.dart';
=======
import 'presentation/screens/customers/customers.dart';
import 'presentation/screens/dashboard/dashboard.dart';
import 'presentation/screens/salesperson/widget/salesperson.dart';
import 'presentation/screens/inventory/inventory.dart';
import 'presentation/screens/saleshistory/saleshistory.dart';
import 'presentation/screens/login/login.dart';
import 'presentation/screens/products/products.dart';
import 'presentation/screens/purchaseshistory/purchaseshistory.dart';
import 'presentation/screens/reports/reports.dart';
import 'presentation/screens/services/services.dart';
import 'presentation/screens/settings/settings.dart';
>>>>>>> origin/develop

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.login,

      routes: {
        AppRoutes.dashboard: (context) => const DashboardScreen(),

        AppRoutes.inventory: (context) => const InventoryScreen(),

        AppRoutes.purchaseHistory: (context) => const PurchaseHistoryScreen(),

        AppRoutes.saleHistory: (context) => const SalesScreen(),

        AppRoutes.products: (context) => const ProductsScreen(),

        AppRoutes.services: (context) => const ServicesScreen(),

        AppRoutes.customers: (context) => const CustomersScreen(),

        AppRoutes.reports: (context) => const ReportScreen(),

        AppRoutes.settings: (context) => const SettingsScreen(),

        AppRoutes.login: (context) => const LoginScreen(),

        AppRoutes.salesperson: (context) => const SalespersonScreen(),
      },
    );
  }
}
