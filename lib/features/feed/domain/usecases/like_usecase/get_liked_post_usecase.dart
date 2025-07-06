import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/failures.dart';

import '../../repositories/ukm_feed_repository.dart';

class GetLikedPostUsecase {
  final UkmFeedRepository repository;

  GetLikedPostUsecase({required this.repository});
   Future<Either<Failures, List<int>>> execute() => repository.getLikedPosts();
}