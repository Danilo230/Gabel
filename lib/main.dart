import 'package:flutter/material.dart';

import 'screens/customers/customers.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/inventory/inventory.dart';
import 'screens/login/login.dart';
import 'screens/logs/logs.dart';
import 'screens/products/products.dart';
import 'screens/reports/reports.dart';
import 'screens/services/services.dart';
import 'screens/settings/settings.dart';
import 'screens/customers/customers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReportsScreen(),
    );
  }
}
