import 'package:prova_target/features/auth/domain/exceptions/auth_exception.dart';

import '../services/auth_service_in_memory_storage.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository_protocols/auth_repository_protocol.dart';
import '../models/user_model.dart';

class AuthRepository implements AuthRepositoryProtocol {
  final authService = AuthServiceInMemoryStorage();

  @override
  Future<User> createUser(String name, String loginUsername, String password) async {
    try {
      Map<String, dynamic> params = {"name": name, "login_username": loginUsername, "password": password};

      Map<String, dynamic> response = await authService.createUser(params);
      return UserModel.fromJson(response).toEntity();
    } on ServiceException catch (errorCode) {
      switch (errorCode.message) {
        case 'USERNAME_ALREADY_REGISTERED':
          throw AuthException('Usuário já registrado');
        case 'INVALID_USERNAME':
          throw AuthException('Nome de usuário inválido');
        case 'INVALID_USERNAME_LENGTH':
          throw AuthException('Comprimento inválido para o nome de usuário');
        case 'INVALID_PASSWORD':
          throw AuthException('Senha inválida');
        case 'INVALID_PASSWORD_LENGTH':
          throw AuthException('Comprimento inválido para a senha');
        default:
          throw AuthException('Erro desconhecido ao criar usuário');
      }
    }
  }

  @override
  Future<User> login(String loginUsername, String password) async {
    try {
      Map<String, dynamic> params = {"login_username": loginUsername, "password": password};

      Map<String, dynamic> response = await authService.login(params);
      return UserModel.fromJson(response).toEntity();
    } on ServiceException catch (errorCode) {
      switch (errorCode.message) {
        case 'USER_DOES_NOT_EXIST':
          throw AuthException('Usuário não existe');
        case 'WRONG_PASSWORD':
          throw AuthException('Senha errada');
        case 'INVALID_USERNAME':
          throw AuthException('Nome de usuário inválido');
        case 'INVALID_USERNAME_LENGTH':
          throw AuthException('Comprimento inválido para o nome de usuário');
        case 'INVALID_PASSWORD':
          throw AuthException('Senha inválida');
        case 'INVALID_PASSWORD_LENGTH':
          throw AuthException('Comprimento inválido para a senha');
        default:
          throw AuthException('Erro desconhecido ao fazer login');
      }
    }
  }

  @override
  Future<void> logout() async {
    await authService.logout();
  }

  @override
  Future<User?> getLoggedInUser() async {
    Map<String, dynamic>? response = await authService.getLoggedInUser();
    if (response != null) {
      return UserModel.fromJson(response).toEntity();
    }

    return null;
  }
}
