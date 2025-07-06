import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../repositories/ukm_feed_repository.dart';

class TogglePostLikeUseCase {
  final UkmFeedRepository repository;
  TogglePostLikeUseCase(this.repository);
  Future<Either<Failures, void>> execute(int id) => repository.togglePostLike(id);
}