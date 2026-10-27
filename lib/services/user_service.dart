import 'package:gabel/data/models/user_model.dart';
import 'package:gabel/data/repositories/user_repository.dart';

class UserService {
  final UserRepository _userRepository;
  const UserService(this._userRepository);

  Future<UserModel> getUserById(int id) async {
    return await _userRepository.getById(id);
  }

  Future<void> updateUser(int id, UserModel data) async{
    await _userRepository.update(id, data);
  }

  Future<void> deleteUser(int id) async {
    await _userRepository.delete(id);
  }
}