import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/repositories/auth_repository.dart';
import 'package:gabel/data/repositories/token_repository.dart';
import 'package:gabel/presentation/providers/authenticatio_provider.dart';
import 'package:gabel/services/authentication_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(), dispose: (client) => client.dispose());

  // Register repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository());

  // Register service
  getIt.registerLazySingleton<AuthenticationService>(() => AuthenticationService(getIt<AuthRepository>(), getIt<TokenRepository>()));

  //Register Provider
  getIt.registerFactory<AuthenticationProvider>(() => AuthenticationProvider(getIt<AuthenticationService>()));
}