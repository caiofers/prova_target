import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import '../../domain/exceptions/auth_exception.dart';
import '../../domain/repository_protocols/auth_repository_protocol.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_user.dart';

part 'login.store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  LoginStoreBase();

  @observable
  User? _user;

  @observable
  String _loginUsername = '';

  @observable
  String _password = '';

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @computed
  User? get user => _user;

  @action
  void setLoginUsername(String value) => _loginUsername = value;

  @action
  void setPassword(String value) => _password = value;

  @action
  void setErrorMessage(String value) => errorMessage = value;

  @action
  Future<void> loginUser(BuildContext context) async {
    try {
      isLoading = true;

      if (context.mounted) {
        _user = await LoginUser(_getRepository(context)).execute(_loginUsername, _password);
      } else {
        throw Exception();
      }

      isLoading = false;
      if (context.mounted) {
        Navigator.pushNamed(context, '/records');
      } else {
        throw Exception();
      }
      setErrorMessage('');
    } on AuthException catch (e) {
      isLoading = false;
      setErrorMessage(e.message);
    } catch (e) {
      isLoading = false;
      setErrorMessage("Erro inesperado, entre em contato com o dev.");
    }
  }

  AuthRepositoryProtocol _getRepository(BuildContext context) {
    return Provider.of<AuthRepositoryProtocol>(context, listen: false);
  }
}
