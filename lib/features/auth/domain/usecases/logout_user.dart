import '../repository_protocols/auth_repository_protocol.dart';

class LogoutUser {
  final AuthRepositoryProtocol _repository;

  LogoutUser(this._repository);

  execute() {
    _repository.logout();
  }
}
