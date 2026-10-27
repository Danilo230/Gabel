import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/presentation/providers/authenticatio_provider.dart' as _authenticationService;
import 'package:gabel/services/authentication_service.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown,
}

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationService _authenticationService;
  AuthenticationProvider(this._authenticationService);

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  AuthenticationStatus _authStatus = AuthenticationStatus.unknown;
  AuthenticationStatus get authStatus => _authStatus;
  bool get isAuthenticated => _authStatus == AuthenticationStatus.authenticated;
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  List<String> _roles = [];
  List<String> get roles => _roles;
  bool get isSalesperson =>
      _roles.any((r) => r.toLowerCase() == 'vendedor');

  Future<void> login({required String username, required String password}) async {
    if (_isSubmitting) return;

    _isSubmitting = true;
    _errorMessage = null;              
    notifyListeners();

    try {
      final token = await _authenticationService.login(username, password);
      _roles = token.roles.toList();   
      debugPrint('ROLES: $_roles');   
      _authStatus = AuthenticationStatus.authenticated;
    } on AppException catch (e) {
      _errorMessage = e.toString();
    } on FormatException catch (e) {
      _errorMessage = 'Error de formato: ${e.message}';
    } catch (e, stack) {
      debugPrint('ERROR LOGIN: $e');
      debugPrint('$stack');
      _errorMessage = 'ocurrio un error inesperado. intentalo de nuevo mas tarde';
    }

    _isSubmitting = false;
    notifyListeners();
  }

  Future<void> checkSession() async {
    try {
      final bool isAuthenticated = await _authenticationService.isLoggedIn();
      if (isAuthenticated) {
        final token = await _authenticationService.getStoredToken();
        _roles = token?.roles.toList() ?? [];
      }
      _authStatus = isAuthenticated
          ? AuthenticationStatus.authenticated
          : AuthenticationStatus.unauthenticated;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. please try again';
      _authStatus = AuthenticationStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
  try {
    await _authenticationService.logout();
  } catch (e) {
    debugPrint('ERROR LOGOUT: $e');
  } finally {
    _roles = [];
    _errorMessage = null;
    _authStatus = AuthenticationStatus.unauthenticated;
    notifyListeners();
  }
}
}
