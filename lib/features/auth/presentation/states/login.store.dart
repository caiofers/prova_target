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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _loginUsernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginStoreBase();

  dispose() {
    _nameController.dispose();
    _loginUsernameController.dispose();
    _passwordController.dispose();
  }

  TextEditingController get nameController => _nameController;
  TextEditingController get loginUsernameController => _loginUsernameController;
  TextEditingController get passwordController => _passwordController;

  @observable
  User? _user;

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @computed
  User? get user => _user;

  @action
  void setErrorMessage(String value) => errorMessage = value;

  @action
  Future<void> loginUser(BuildContext context) async {
    try {
      isLoading = true;
      if (context.mounted) {
        _user =
            await LoginUser(_getRepository(context)).execute(_loginUsernameController.text, _passwordController.text);
        _loginUsernameController.clear();
        _passwordController.clear();
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
