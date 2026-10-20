import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/user_model.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository(this.apiClient);

  Future<UserModel> getById(int userId) async {
    final json = await apiClient.get('${ApiConstants.instance.baseUrl}/users/$userId');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return UserModel.fromJson(json);
  }
  
  Future<List<UserModel>> getAll() async {
    final json = await apiClient.get('${ApiConstants.instance.baseUrl}/users');
    if (json == null) throw const NotFoundException();
    if (json is! List) throw ParsingException();

    return json.map((userJson) {
      if (userJson is! Map<String, dynamic>) throw ParsingException();
      return UserModel.fromJson(userJson);
    }).toList();
  }
}