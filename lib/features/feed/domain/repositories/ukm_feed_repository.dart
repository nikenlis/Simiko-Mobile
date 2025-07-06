import 'package:dartz/dartz.dart';
import 'package:simiko/features/feed/domain/entities/ukm_feed_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/detail_event_entity.dart';
import '../entities/detail_post_entity.dart';

abstract class UkmFeedRepository {
  Future<Either<Failures, List<UkmFeedEntity>>> ukmFeed();
  Future<Either<Failures, DetailPostEntity>> detailPost({required int id});
  Future<Either<Failures, DetailEventEntity>> detailEvent({required int id});

  Future<Either<Failures, void>> togglePostLike(int id);
  Future<Either<Failures, void>> toggleEventLike(int id);
  Future<Either<Failures, bool>> isPostLiked(int id);
  Future<Either<Failures, bool>> isEventLiked(int id);
  Future<Either<Failures, List<int>>> getLikedPosts();
  Future<Either<Failures, List<int>>> getLikedEvents();

}