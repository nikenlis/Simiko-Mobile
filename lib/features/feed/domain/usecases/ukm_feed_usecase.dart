import 'package:dartz/dartz.dart';
import 'package:simiko/features/feed/domain/entities/ukm_feed_entity.dart';
import 'package:simiko/features/feed/domain/repositories/ukm_feed_repository.dart';

import '../../../../core/error/failures.dart';

class UkmFeedUsecase {
  final UkmFeedRepository repository;

  UkmFeedUsecase({required this.repository});
  Future<Either<Failures, List<UkmFeedEntity>>> execute() {
    return repository.ukmFeed();
  }

  
}
