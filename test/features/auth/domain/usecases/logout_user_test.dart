import 'package:flutter_test/flutter_test.dart';
import 'package:prova_target/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:prova_target/features/auth/domain/entities/user.dart';
import 'package:prova_target/features/auth/domain/repository_protocols/auth_repository_protocol.dart';
import 'package:prova_target/features/auth/domain/usecases/create_user.dart';
import 'package:prova_target/features/auth/domain/usecases/get_logged_user.dart';
import 'package:prova_target/features/auth/domain/usecases/login_user.dart';
import 'package:prova_target/features/auth/domain/usecases/logout_user.dart';

void main() {
  late AuthRepositoryProtocol repository;
  late LogoutUser usecase;

  group(
    'create user tests',
    () {
      setUp(() {
        repository = AuthRepositoryMock();
        CreateUser(repository).execute("Caio", "testecaio", "1234");
        LoginUser(repository).execute("testecaio", "1234");
        usecase = LogoutUser(repository);
      });
      test(
        'sucess to logout',
        () async {
          User? user = await GetLoggedUser(repository).execute();
          assert(!identical(user, null));

          usecase.execute();
          User? loggedUser = await GetLoggedUser(repository).execute();

          assert(identical(loggedUser, null));
        },
      );
    },
  );
}
