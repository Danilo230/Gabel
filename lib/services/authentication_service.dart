import 'package:gabel/data/models/token_model.dart';
import 'package:gabel/data/models/user_model.dart';
import 'package:gabel/data/repositories/auth_repository.dart';

class AuthenticationService {
  final AuthRepository _authRepository;

  AuthenticationService(this._authRepository);

  Future<void> login(String username, String password) async {
    final trimmedUsername = username.trim();
    final trimmedPassword = password.trim();

    if (trimmedUsername.isEmpty || trimmedPassword.isEmpty) {
      throw Exception('Username and password cannot be empty.');
    }

   TokenModel token = await _authRepository.login(username, password);
  }

  Future<UserModel> getCurrentUser() async {
    return await _authRepository.currentUser();
  }

//  Future<void> logout() async {
    // Implement logout logic if needed, e.g., clearing tokens or session data.
//  }
}