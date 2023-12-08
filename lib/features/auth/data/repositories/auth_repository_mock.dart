import 'package:prova_target/features/auth/domain/exceptions/login_user_exception.dart';

import '../services/in_memory_storage_service.dart';

import '../../domain/entities/user.dart';
import '../../domain/exceptions/create_user_exception.dart';
import '../../domain/repository_protocols/auth_repository_protocol.dart';
import '../models/user_model.dart';

class AuthRepositoryMock implements AuthRepositoryProtocol {
  final authService = InMemoryAuthService();

  @override
  Future<User> createUser(String name, String loginUsername, String password) async {
    try {
      Map<String, dynamic> params = {"name": name, "login_username": loginUsername, "password": password};

      Map<String, dynamic> response = await authService.createUser(params);
      return UserModel.fromJson(response).toEntity();
    } on ServiceException catch (errorCode) {
      switch (errorCode.message) {
        case 'USERNAME_ALREADY_REGISTERED':
          throw CreateUserException('Usuário já registrado');
        case 'INVALID_USERNAME':
          throw CreateUserException('Nome de usuário inválido');
        case 'INVALID_USERNAME_LENGTH':
          throw CreateUserException('Comprimento inválido para o nome de usuário');
        case 'INVALID_PASSWORD':
          throw CreateUserException('Senha inválida');
        case 'INVALID_PASSWORD_LENGTH':
          throw CreateUserException('Comprimento inválido para a senha');
        default:
          throw CreateUserException('Erro desconhecido ao criar usuário');
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
          throw LoginUserException('Usuário não existe');
        case 'WRONG_PASSWORD':
          throw LoginUserException('Senha errada');
        case 'INVALID_USERNAME':
          throw LoginUserException('Nome de usuário inválido');
        case 'INVALID_USERNAME_LENGTH':
          throw LoginUserException('Comprimento inválido para o nome de usuário');
        case 'INVALID_PASSWORD':
          throw LoginUserException('Senha inválida');
        case 'INVALID_PASSWORD_LENGTH':
          throw LoginUserException('Comprimento inválido para a senha');
        default:
          throw LoginUserException('Erro desconhecido ao fazer login');
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
