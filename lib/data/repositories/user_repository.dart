
import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/user_model.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<UserModel> getById(int userId) async {
    final json = await _apiClient.get('${ApiConstants.users}/$userId');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();
    
    return UserModel.fromJson(json);
  }

  Future<void> update(int id, UserModel data) async {
    await _apiClient.put('${ApiConstants.users}/$id', body: data.toUpdateJson());
  }

  Future<void> delete(int id) async {
    await _apiClient.delete("${ApiConstants.users}/$id");
  }

}