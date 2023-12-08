import '../entities/user.dart';
import '../repository_protocols/auth_repository_protocol.dart';

class LoginUser {
  final AuthRepositoryProtocol _repository;

  LoginUser(this._repository);

  Future<User> execute(String loginUsername, String password) async {
    return await _repository.login(loginUsername, password);
  }
}
