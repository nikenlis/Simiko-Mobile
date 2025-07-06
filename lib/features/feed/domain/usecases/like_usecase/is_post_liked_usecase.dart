import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/failures.dart';

import '../../repositories/ukm_feed_repository.dart';

class IsPostLikedUseCase {
  final UkmFeedRepository repository;
  IsPostLikedUseCase(this.repository);
  Future<Either<Failures, bool>> execute(int id) => repository.isPostLiked(id);
}