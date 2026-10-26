import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/presentation/providers/authenticatio_provider.dart';
import 'package:gabel/presentation/theme/app_typography.dart';
import 'package:provider/provider.dart';
import 'presentation/widgets/app_routes.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  setupDependencies();

  getIt<AuthenticationProvider>().checkSession();

  runApp(
    ChangeNotifierProvider(
      create: (_) => getIt<AuthenticationProvider>(),
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppTypography.fontFamily,
        textTheme: AppTypography.textTheme,
      ),

      home: Scaffold(body: _AuthGuard(),),

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

class _AuthGuard extends StatelessWidget {
  const _AuthGuard();

  @override
  Widget build(BuildContext context) {

    var authProvider = context.watch<AuthenticationProvider>();
    switch (authProvider.authStatus) {
      case AuthenticationStatus.authenticated:
        return const Center(child: Text('Authenticated'));
      case AuthenticationStatus.unauthenticated:
        return const LoginScreen();
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

}