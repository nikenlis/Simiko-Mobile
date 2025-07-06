import 'package:dartz/dartz.dart';
import 'package:simiko/features/home/domain/entities/top_event_entity.dart';
import 'package:simiko/features/home/domain/repositories/top_event_repository.dart';

import '../../../../core/error/failures.dart';

class TopEventUsecase {
  final TopEventRepository repository;

  TopEventUsecase({required this.repository});
  Future<Either<Failures, List<TopEventEntity>>> execute (){
    return repository.all();
  }
}