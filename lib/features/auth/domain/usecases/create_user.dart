import '../entities/user.dart';
import '../exceptions/auth_exception.dart';
import '../repository_protocols/auth_repository_protocol.dart';

class CreateUser {
  final AuthRepositoryProtocol _repository;

  CreateUser(this._repository);

  Future<User> execute(String name, String loginUsername, String password) async {
    try {
      return await _repository.createUser(name, loginUsername, password);
    } on AuthException {
      rethrow;
    }
  }
}
