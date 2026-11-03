import 'package:gabel/data/models/current_user_model.dart';
import 'package:gabel/data/models/token_model.dart';
import 'package:gabel/data/repositories/auth_repository.dart';
import 'package:gabel/data/repositories/token_repository.dart';

class AuthenticationService {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  AuthenticationService(this._authRepository, this._tokenRepository);

  Future<TokenModel> login(String username, String password) async {
    final trimmedUsername = username.trim();
    final trimmedPassword = password.trim();

    if (trimmedUsername.isEmpty || trimmedPassword.isEmpty) {
      throw Exception('Username and password cannot be empty.');
    }

   final TokenModel token = await _authRepository.login(trimmedUsername, trimmedPassword);
   await _tokenRepository.saveToken(token);
   return token;
  }

  Future<TokenModel?> getStoredToken() => _tokenRepository.getToken();

  Future<CurrentUserModel> getCurrentUser() async {
    return await _authRepository.getCurrentUser();
  }

  Future<bool> isLoggedIn() => _tokenRepository.hasValidToken();

  Future<void> logout() async {
    await _tokenRepository.removeToken();
  }
}