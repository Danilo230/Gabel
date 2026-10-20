import 'package:gabel/core/constants/regular_expressions.dart';
import 'package:gabel/data/models/token_model.dart';
// import 'package:gabel/data/models/token_model.dart';
import 'package:gabel/data/models/user_model.dart';
import 'package:gabel/data/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;
  // final TokenService _tokenService;

  // AuthService(this._authRepository, this._tokenService);
  AuthService(this._authRepository);

  Future<TokenModel> login(String username, String password) async {
    final trimmedUsername = username.trim();
    final trimmedPassword = password.trim();

    if (trimmedUsername.isEmpty || trimmedPassword.isEmpty) {
      throw const FormatException('El nombre de usuario y la contraseña no pueden estar vacíos.');
    }

    if (!CommonRegex.usernameRegex.hasMatch(trimmedUsername)) {
      throw const FormatException('El nombre de usuario debe tener entre 3 y 20 caracteres alfanuméricos o guiones bajos.');
    }

    if (!CommonRegex.passwordRegex.hasMatch(trimmedPassword)) {
      throw const FormatException('La contraseña debe tener al menos 8 caracteres, incluyendo letras y números.');
    }

    final TokenModel token = await _authRepository.login(username, password);
    return token;
  }

  Future<UserModel> getCurrentUser() async {
    return await _authRepository.currentUser();
  }
}