import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/repositories/auth_repository.dart';
import 'package:gabel/data/repositories/damaged_product_repository.dart';
import 'package:gabel/data/repositories/inventory_repository.dart';
import 'package:gabel/data/repositories/customer_repository.dart';
import 'package:gabel/data/repositories/token_repository.dart';
import 'package:gabel/data/repositories/user_repository.dart';
import 'package:gabel/presentation/providers/authenticatio_provider.dart';
import 'package:gabel/presentation/providers/damaged_product_provider.dart';
import 'package:gabel/presentation/providers/inventory_provider.dart';
import 'package:gabel/presentation/providers/user_provider.dart';
import 'package:gabel/services/authentication_service.dart';
import 'package:gabel/services/damaged_product_service.dart';
import 'package:gabel/services/inventory_service.dart';
import 'package:gabel/services/product_service.dart';
import 'package:gabel/services/customer_service.dart';
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
  getIt.registerLazySingleton<UserRepository>(() => UserRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<InventoryRepository>(() => InventoryRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<DamagedProductRepository>(() => DamagedProductRepository(getIt<ApiClient>()));

  // Register service
  getIt.registerLazySingleton<AuthenticationService>(() => AuthenticationService(getIt<AuthRepository>(), getIt<TokenRepository>()));
  getIt.registerLazySingleton<UserService>(() => UserService(getIt<UserRepository>()));
  getIt.registerLazySingleton<InventoryService>(() => InventoryService(getIt<InventoryRepository>()));
  getIt.registerLazySingleton<DamagedProductService>(() => DamagedProductService(getIt<DamagedProductRepository>()));

  //Register Provider
  getIt.registerLazySingleton<AuthenticationProvider>(() => AuthenticationProvider(getIt<AuthenticationService>()),);
  getIt.registerFactory<UserProvider>(() => UserProvider(getIt<UserService>()));
  getIt.registerFactory<InventoryProvider>(() => InventoryProvider(getIt<InventoryService>(), getIt<ProductService>()));
  getIt.registerFactory<DamagedProductProvider>(() => DamagedProductProvider(getIt<DamagedProductService>()));
}
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<CustomerRepository>(
    () => CustomerRepository(getIt<ApiClient>()),
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

  getIt.registerLazySingleton<CustomerService>(
    () => CustomerService(getIt<CustomerRepository>()),
  );

  //Register Provider
  getIt.registerLazySingleton<AuthenticationProvider>(
    () => AuthenticationProvider(getIt<AuthenticationService>()),
  );
  getIt.registerFactory<UserProvider>(() => UserProvider(getIt<UserService>()));
}
