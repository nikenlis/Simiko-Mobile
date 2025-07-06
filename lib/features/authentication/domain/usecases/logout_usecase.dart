import 'package:dartz/dartz.dart';
import 'package:simiko/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';

class LogoutUsecase {
  final AuthRepository repository;

  LogoutUsecase({required this.repository});

  Future<Either<Failures, Unit>> execute() {
    return repository.logout();
  }
}