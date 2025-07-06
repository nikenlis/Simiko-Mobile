import 'package:dartz/dartz.dart';
import 'package:simiko/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/profile_entity.dart';

class ProfileUsecase {
  final ProfileRepository repository;

  ProfileUsecase({required this.repository});

   Future<Either<Failures, ProfileEntity>> execute() {
    return repository.getProfile();
   }

}