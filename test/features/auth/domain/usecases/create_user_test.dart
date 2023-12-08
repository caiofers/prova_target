import 'package:flutter_test/flutter_test.dart';
import 'package:prova_target/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:prova_target/features/auth/domain/entities/user.dart';
import 'package:prova_target/features/auth/domain/exceptions/create_user_exception.dart';
import 'package:prova_target/features/auth/domain/repository_protocols/auth_repository_protocol.dart';
import 'package:prova_target/features/auth/domain/usecases/create_user.dart';

void main() {
  late AuthRepositoryProtocol repository;
  late CreateUser usecase;
  group(
    'create user tests',
    () {
      setUp(() {
        repository = AuthRepositoryMock();
        usecase = CreateUser(repository);
      });
      test(
        'sucess to create user',
        () async {
          User expectedUser = User("Test", "testecaio", "1234");
          User user = await usecase.execute("Test", "testecaio", "1234");

          expect(expectedUser.loginUsername, user.loginUsername);
        },
      );

      test(
        'exception if user already exists',
        () async {
          await usecase.execute("Test", "testecaio", "1234");
          expect(
              () => usecase.execute("Test", "testecaio", "123456789012345678901"), throwsA(isA<CreateUserException>()));
        },
      );
      test(
        'exception with invalid password length',
        () async {
          expect(() => usecase.execute("Test", "testecaio", "1"), throwsA(isA<CreateUserException>()));
          expect(() => usecase.execute("Test", "testecaio2", "123456789012345678901"),
              throwsA(isA<CreateUserException>()));
        },
      );

      test(
        'exception with invalid password',
        () async {
          expect(() => usecase.execute("Test", "testecaio", "12!34"), throwsA(isA<CreateUserException>()));
          expect(() => usecase.execute("Test", "testecaio2", "1234 "), throwsA(isA<CreateUserException>()));
        },
      );

      test(
        'exception with invalid username length',
        () async {
          expect(() => usecase.execute("Test", "t", "1234"), throwsA(isA<CreateUserException>()));
          expect(() => usecase.execute("Test", "testecaiotestecaiotestecaioteste", "1234"),
              throwsA(isA<CreateUserException>()));
        },
      );

      test(
        'exception with invalid username',
        () async {
          expect(() => usecase.execute("Test", "testecaio ", "1234"), throwsA(isA<CreateUserException>()));
        },
      );
    },
  );
}
