import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/detail_post_entity.dart';
import '../repositories/ukm_feed_repository.dart';

class DetailPostUsecase {
  final UkmFeedRepository repository;

  DetailPostUsecase({required this.repository});
   Future<Either<Failures, DetailPostEntity>> execute({required int id}) {
    return repository.detailPost(id: id);
   }
}