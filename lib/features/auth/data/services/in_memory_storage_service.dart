class ServiceException implements Exception {
  final String message;

  ServiceException(this.message);
}

enum CreateUserErrorsCode {
  alreadyRegistered,
  invalidUsername,
  invalidUsernameLength,
  invalidPassword,
  invalidPasswordLength;

  String get code {
    switch (this) {
      case CreateUserErrorsCode.alreadyRegistered:
        return 'USERNAME_ALREADY_REGISTERED';
      case CreateUserErrorsCode.invalidUsername:
        return 'INVALID_USERNAME';
      case CreateUserErrorsCode.invalidUsernameLength:
        return 'INVALID_USERNAME_LENGTH';
      case CreateUserErrorsCode.invalidPassword:
        return 'INVALID_PASSWORD';
      case CreateUserErrorsCode.invalidPasswordLength:
        return 'INVALID_PASSWORD_LENGTH';
    }
  }
}

enum LoginErrorsCode {
  doesNotExist,
  wrongPassword,
  invalidUsername,
  invalidUsernameLength,
  invalidPassword,
  invalidPasswordLength;

  String get code {
    switch (this) {
      case LoginErrorsCode.doesNotExist:
        return 'USER_DOES_NOT_EXIST';
      case LoginErrorsCode.wrongPassword:
        return 'WRONG_PASSWORD';
      case LoginErrorsCode.invalidUsername:
        return 'INVALID_USERNAME';
      case LoginErrorsCode.invalidUsernameLength:
        return 'INVALID_USERNAME_LENGTH';
      case LoginErrorsCode.invalidPassword:
        return 'INVALID_PASSWORD';
      case LoginErrorsCode.invalidPasswordLength:
        return 'INVALID_PASSWORD_LENGTH';
    }
  }
}

class InMemoryAuthService {
  final List<Map<String, dynamic>> _localUsers = [];
  final int _delayInMilliseconds = 500;
  Map<String, dynamic>? _loggedInUser;

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> params) async {
    String username = params['login_username'];
    String password = params['password'];

    bool alreadyHaveUsername = _localUsers.any((element) => element['login_username'] == username);
    if (alreadyHaveUsername) {
      throw ServiceException(CreateUserErrorsCode.alreadyRegistered.code);
    }

    if (username.length < 2 || username.length > 20) {
      throw ServiceException(CreateUserErrorsCode.invalidUsernameLength.code);
    }

    if (!_validateUsername(username)) {
      throw ServiceException(CreateUserErrorsCode.invalidUsername.code);
    }

    if (password.length < 2 || password.length > 20) {
      throw ServiceException(CreateUserErrorsCode.invalidPasswordLength.code);
    }

    if (!_validatePassword(password)) {
      throw ServiceException(CreateUserErrorsCode.invalidPassword.code);
    }

    Future.delayed(Duration(milliseconds: _delayInMilliseconds));
    _localUsers.add(params);
    return _localUsers.firstWhere((element) => element['login_username'] == params['login_username']);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> params) async {
    String username = params['login_username'];
    String password = params['password'];

    Map<String, dynamic>? user;

    try {
      user = _localUsers.firstWhere((element) => element['login_username'] == username);
    } catch (e) {
      throw ServiceException(LoginErrorsCode.doesNotExist.code);
    }

    if (username.length < 2 || username.length > 20) {
      throw ServiceException(LoginErrorsCode.invalidUsernameLength.code);
    }

    if (!_validateUsername(username)) {
      throw ServiceException(LoginErrorsCode.invalidUsername.code);
    }

    if (password.length < 2 || password.length > 20) {
      throw ServiceException(LoginErrorsCode.invalidPasswordLength.code);
    }

    if (!_validatePassword(password)) {
      throw ServiceException(LoginErrorsCode.invalidPassword.code);
    }

    if (user['password'] != password) {
      throw ServiceException(LoginErrorsCode.wrongPassword.code);
    }

    Future.delayed(Duration(milliseconds: _delayInMilliseconds));
    _loggedInUser = user;
    return _localUsers.firstWhere((element) => element['login_username'] == params['login_username']);
  }

  Future<void> logout() async {
    Future.delayed(Duration(milliseconds: _delayInMilliseconds));
    _loggedInUser = null;
  }

  Future<Map<String, dynamic>?> getLoggedInUser() async {
    Future.delayed(Duration(milliseconds: _delayInMilliseconds));
    return _loggedInUser;
  }

  bool _validateUsername(String loginUsername) {
    RegExp regex = RegExp(r'^.{2,20}[^\s]$');
    return regex.hasMatch(loginUsername);
  }

  bool _validatePassword(String password) {
    RegExp regex = RegExp(r'^[a-zA-Z1-9]{2,20}$');
    return regex.hasMatch(password);
  }
}
