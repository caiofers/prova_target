import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../domain/exceptions/auth_exception.dart';
import '../../domain/repository_protocols/auth_repository_protocol.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_user.dart';

part 'login.store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final AuthRepositoryProtocol _repository;

  LoginStoreBase(this._repository);

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

      _user = await LoginUser(_repository).execute(_loginUsername, _password);

      isLoading = false;
      if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => const Placeholder()));
      setErrorMessage('');
    } on AuthException catch (e) {
      isLoading = false;
      setErrorMessage(e.message);
    }
  }
}
