// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  Computed<User?>? _$userComputed;

  @override
  User? get user => (_$userComputed ??=
          Computed<User?>(() => super.user, name: 'LoginStoreBase.user'))
      .value;

  late final _$_userAtom = Atom(name: 'LoginStoreBase._user', context: context);

  @override
  User? get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(User? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$_loginUsernameAtom =
      Atom(name: 'LoginStoreBase._loginUsername', context: context);

  @override
  String get _loginUsername {
    _$_loginUsernameAtom.reportRead();
    return super._loginUsername;
  }

  @override
  set _loginUsername(String value) {
    _$_loginUsernameAtom.reportWrite(value, super._loginUsername, () {
      super._loginUsername = value;
    });
  }

  late final _$_passwordAtom =
      Atom(name: 'LoginStoreBase._password', context: context);

  @override
  String get _password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'LoginStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'LoginStoreBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loginUserAsyncAction =
      AsyncAction('LoginStoreBase.loginUser', context: context);

  @override
  Future<void> loginUser(BuildContext context) {
    return _$loginUserAsyncAction.run(() => super.loginUser(context));
  }

  late final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase', context: context);

  @override
  void setLoginUsername(String value) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setLoginUsername');
    try {
      return super.setLoginUsername(value);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String value) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
user: ${user}
    ''';
  }
}
