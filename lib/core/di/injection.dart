import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/repositories/auth_repository.dart';
import 'package:gabel/data/repositories/damaged_product_repository.dart';
import 'package:gabel/data/repositories/inventory_repository.dart';
import 'package:gabel/data/repositories/customer_repository.dart';
import 'package:gabel/data/repositories/purchase_repository.dart';
import 'package:gabel/data/repositories/sale_repository.dart';
import 'package:gabel/data/repositories/product_repository.dart';
import 'package:gabel/data/repositories/service_repository.dart';
import 'package:gabel/data/repositories/supplier_repository.dart';
import 'package:gabel/data/repositories/token_repository.dart';
import 'package:gabel/data/repositories/user_repository.dart';
import 'package:gabel/presentation/providers/authenticatio_provider.dart';
import 'package:gabel/presentation/providers/customer_provider.dart';
import 'package:gabel/presentation/providers/damaged_product_provider.dart';
import 'package:gabel/presentation/providers/inventory_provider.dart';
import 'package:gabel/presentation/providers/purchase_provider.dart';
import 'package:gabel/presentation/providers/sale_provider.dart';
import 'package:gabel/presentation/providers/supplier_provider.dart';
import 'package:gabel/presentation/providers/user_provider.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import 'package:gabel/presentation/providers/service_provider.dart';
import 'package:gabel/services/authentication_service.dart';
import 'package:gabel/services/damaged_product_service.dart';
import 'package:gabel/services/inventory_service.dart';
import 'package:gabel/services/product_service.dart';
import 'package:gabel/services/customer_service.dart';
import 'package:gabel/services/purchase_service.dart';
import 'package:gabel/services/sale_service.dart';
import 'package:gabel/services/services_service.dart';
import 'package:gabel/services/supplier_service.dart';
import 'package:gabel/services/user_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(
    () =>
        ApiClient(authTokenProvider: () => getIt<TokenRepository>().getToken()),
    dispose: (client) => client.dispose(),
  );

  // Register repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository());
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<DamagedProductRepository>(
    () => DamagedProductRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<CustomerRepository>(
    () => CustomerRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<PurchaseRepository>(
    () => PurchaseRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<SaleRepository>(
    () => SaleRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ServiceRepository>(
    () => ServiceRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<SupplierRepository>(
    () => SupplierRepository(getIt<ApiClient>()),
  );

  // Register service
  getIt.registerLazySingleton<AuthenticationService>(
    () => AuthenticationService(
      getIt<AuthRepository>(),
      getIt<TokenRepository>(),
    ),
  );
  getIt.registerLazySingleton<UserService>(
    () => UserService(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<InventoryService>(
    () => InventoryService(getIt<InventoryRepository>()),
  );
  getIt.registerLazySingleton<DamagedProductService>(
    () => DamagedProductService(getIt<DamagedProductRepository>()),
  );
  getIt.registerLazySingleton<CustomerService>(
    () => CustomerService(getIt<CustomerRepository>()),
  );
  getIt.registerLazySingleton<PurchaseService>(
    () => PurchaseService(getIt<PurchaseRepository>()),
  );
  getIt.registerLazySingleton<SaleService>(
    () => SaleService(getIt<SaleRepository>()),
  );
  getIt.registerLazySingleton<ProductService>(
    () => ProductService(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<ServicesService>(
    () => ServicesService(getIt<ServiceRepository>()),
  );
  getIt.registerLazySingleton<SupplierService>(
    () => SupplierService(getIt<SupplierRepository>()),
  );

  //Register Provider
  getIt.registerLazySingleton<AuthenticationProvider>(
    () => AuthenticationProvider(getIt<AuthenticationService>()),
  );
  getIt.registerFactory<UserProvider>(() => UserProvider(getIt<UserService>()));
  getIt.registerLazySingleton<InventoryProvider>(
    () => InventoryProvider(getIt<InventoryService>(), getIt<ProductService>()),
  );
  getIt.registerFactory<DamagedProductProvider>(
    () => DamagedProductProvider(getIt<DamagedProductService>()),
  );
  getIt.registerFactory<CustomerProvider>(
    () => CustomerProvider(getIt<CustomerService>()),
  );
  getIt.registerFactory<PurchaseProvider>(
    () => PurchaseProvider(getIt<PurchaseService>()),
  );
  getIt.registerFactory<SaleProvider>(() => SaleProvider(getIt<SaleService>()));
  getIt.registerLazySingleton<ProductProvider>(
    () => ProductProvider(getIt<ProductService>()),
  );
  getIt.registerLazySingleton<ServicesProvider>(
    () => ServicesProvider(getIt<ServicesService>()),
  );
  getIt.registerFactory<SupplierProvider>(
    () => SupplierProvider(getIt<SupplierService>()),
  );
}
