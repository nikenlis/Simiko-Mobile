import 'package:dartz/dartz.dart';
import 'package:simiko/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';

class CheckCredentialUsecase {
  final AuthRepository repository;

  CheckCredentialUsecase({required this.repository});
  Future<Either<Failures, String>> execute() {
    return repository.checkCredential();
  }
}