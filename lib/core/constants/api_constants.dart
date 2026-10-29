import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  String get baseUrl => dotenv.env['BASE_API_URL'] ?? '';
  String get environment => dotenv.env['ENVIRONMENT'] ?? '';

  ApiConstants._privateConstructor();
  static final ApiConstants _instance = ApiConstants._privateConstructor();
  static ApiConstants get instance => _instance;

  static const String login = '/Auth/Login';
  static const String me = '/Auth/me';
  static const String users = '/Users';
  static const String register = '/Auth/Register';
  static const String products = '/Products';
  static const String services = '/Services';
  static const String inventory = '/Inventory';
  static const String purchasesHistory = '/Purchases';
  static const String salesHistory = '/Sales';
  static const String customer = '/Customer';
  static const String damagedProducts = '/DamagedProducts';

  static const Duration timeoutDuration = Duration(seconds: 30);
}
