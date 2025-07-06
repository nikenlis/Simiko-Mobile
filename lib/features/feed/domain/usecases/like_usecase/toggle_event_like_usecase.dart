import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../repositories/ukm_feed_repository.dart';

class ToggleEventLikeUseCase {
  final UkmFeedRepository repository;
  ToggleEventLikeUseCase(this.repository);
  Future<Either<Failures, void>> execute(int id) => repository.toggleEventLike(id);
}