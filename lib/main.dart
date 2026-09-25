import 'package:flutter/material.dart';

import 'screens/customers/customers.dart';
import 'screens/porfile/porfile.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/inventory/inventory.dart';
import 'screens/login/login.dart';
import 'screens/logs/logs.dart';
import 'screens/products/products.dart';
import 'screens/reports/reports.dart';
import 'screens/services/services.dart';
import 'screens/settings/settings.dart';

import 'theme/app_colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: const ProfileScreen(),
    ),
  );
}
