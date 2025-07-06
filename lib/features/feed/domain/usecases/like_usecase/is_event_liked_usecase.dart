import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../repositories/ukm_feed_repository.dart';

class IsEventLikedUseCase {
  final UkmFeedRepository repository;
  IsEventLikedUseCase(this.repository);
  Future<Either<Failures, bool>> execute(int id) => repository.isEventLiked(id);
}