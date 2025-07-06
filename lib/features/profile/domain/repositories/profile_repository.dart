import 'package:dartz/dartz.dart';
import 'package:simiko/features/profile/domain/entities/profile_entity.dart';

import '../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failures, ProfileEntity>> getProfile();
}