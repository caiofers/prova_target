import 'package:flutter_test/flutter_test.dart';
import 'package:prova_target/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:prova_target/features/auth/domain/entities/user.dart';
import 'package:prova_target/features/auth/domain/exceptions/login_user_exception.dart';
import 'package:prova_target/features/auth/domain/repository_protocols/auth_repository_protocol.dart';
import 'package:prova_target/features/auth/domain/usecases/create_user.dart';
import 'package:prova_target/features/auth/domain/usecases/get_logged_user.dart';
import 'package:prova_target/features/auth/domain/usecases/login_user.dart';

void main() {
  late AuthRepositoryProtocol repository;
  late LoginUser usecase;

  group(
    'create user tests',
    () {
      setUp(() {
        repository = AuthRepositoryMock();
        CreateUser(repository).execute("Caio", "testecaio", "1234");
        usecase = LoginUser(repository);
      });
      test(
        'sucess to login',
        () async {
          User user = await usecase.execute("testecaio", "1234");
          User? loggedUser = await GetLoggedUser(repository).execute();

          assert(!identical(loggedUser, null));
          expect(user.loginUsername, loggedUser?.loginUsername);
        },
      );

      test(
        'exception if user does not exists',
        () async {
          expect(() => usecase.execute("testecaio2", "1234"), throwsA(isA<LoginUserException>()));
        },
      );
      test(
        'exception with invalid password length',
        () async {
          expect(() => usecase.execute("testecaio", "1"), throwsA(isA<LoginUserException>()));
          expect(() => usecase.execute("testecaio2", "123456789012345678901"), throwsA(isA<LoginUserException>()));
        },
      );

      test(
        'exception with invalid password',
        () async {
          expect(() => usecase.execute("testecaio", "12!34"), throwsA(isA<LoginUserException>()));
          expect(() => usecase.execute("testecaio2", "1234 "), throwsA(isA<LoginUserException>()));
        },
      );

      test(
        'exception with invalid username length',
        () async {
          expect(() => usecase.execute("t", "1234"), throwsA(isA<LoginUserException>()));
          expect(() => usecase.execute("testecaiotestecaiotestecaioteste", "1234"), throwsA(isA<LoginUserException>()));
        },
      );

      test(
        'exception with invalid username',
        () async {
          expect(() => usecase.execute("testecaio ", "1234"), throwsA(isA<LoginUserException>()));
        },
      );
    },
  );
}
