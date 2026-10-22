import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/token_model.dart';
import 'package:gabel/data/models/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<TokenModel> login(String username, String password) async {
    final json = await _apiClient.post(
      ApiConstants.login,
      body: {
        'username': username,
        'password': password,
      },
      );

      if (json is! Map<String, dynamic>) throw ParsingException();

      return TokenModel.fromJson(json);
  }

  Future<UserModel> currentUser() async {
    final json = await _apiClient.get(ApiConstants.me);
    if (json == null) throw UnauthorizedException();
    if (json is! Map<String, dynamic>) throw ParsingException();
    
    return UserModel.fromJson(json);
  }
}