import 'package:dartz/dartz.dart';
import 'package:simiko/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';

class GetSigninUsecase {
  final AuthRepository repository;

  GetSigninUsecase({required this.repository});

    Future<Either<Failures, String>> execute(
      {required String email,
      required String password}) {
    return repository.signIn(
      password: password,
      email: email
    );
  }

}