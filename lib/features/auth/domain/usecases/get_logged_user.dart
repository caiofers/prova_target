import '../entities/user.dart';
import '../repository_protocols/auth_repository_protocol.dart';

class GetLoggedUser {
  final AuthRepositoryProtocol _repository;

  GetLoggedUser(this._repository);

  Future<User?> execute() async {
    try {
      return await _repository.getLoggedInUser();
    } on Exception {
      return null;
    }
  }
}
