import '../../domain/entities/user.dart';

class UserModel {
  String _name;
  String _loginUsername;
  String _password;

  UserModel(this._name, this._loginUsername, this._password);

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      json['name'] as String,
      json['login_username'] as String,
      json['password'] as String,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(user.name, user.loginUsername, user.password);
  }

  User toEntity() {
    return User(_name, _loginUsername, _password);
  }

  Map<String, Object?> toJson() {
    return {
      'name': _name,
      'login_username': _loginUsername,
      'password': _password,
    };
  }
}
