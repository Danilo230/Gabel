import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
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

  Future<void> login({required String username, required String password}) async {
    if (_isSubmitting) return;

    _isSubmitting = true;
    notifyListeners();

    try {
      await _authenticationService.login(username, password);
      _authStatus = AuthenticationStatus.authenticated;
    } on AppException catch (e) {
      _errorMessage = e.toString();
    } 
    on FormatException catch (e) {
      _errorMessage = 'Error de formato: ${e.message}';
    }
    catch (e, stack) {
      debugPrint('ERROR LOGIN: $e');
      debugPrint('$stack');
      _errorMessage = 'ocurrio un error inesperado. intentalo de nuevo mas tarde';
    } 

    _isSubmitting = false;
    notifyListeners();

  }

  Future<void> checkSession() async{
    try {
      await Future.delayed(const Duration(seconds: 3));
      final bool isAuthenticated = await _authenticationService.isLoggedIn();
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

}