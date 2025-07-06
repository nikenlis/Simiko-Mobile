import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/detail_event_entity.dart';
import '../repositories/ukm_feed_repository.dart';

class DetailEventUsecase {
  final UkmFeedRepository repository;

  DetailEventUsecase({required this.repository});
   Future<Either<Failures, DetailEventEntity>> execute({required int id}) {
    return repository.detailEvent(id: id);
   }
}