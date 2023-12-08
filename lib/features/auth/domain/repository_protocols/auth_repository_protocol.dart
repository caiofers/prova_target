import '../entities/user.dart';

abstract class AuthRepositoryProtocol {
  Future<User> createUser(String name, String loginUsername, String password);
  Future<User> login(String loginUsername, String password);
  Future<void> logout();
  Future<User?> getLoggedInUser();
}
