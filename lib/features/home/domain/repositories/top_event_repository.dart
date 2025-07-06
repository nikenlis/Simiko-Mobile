import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/failures.dart';
import 'package:simiko/features/home/domain/entities/top_event_entity.dart';

abstract class TopEventRepository {
  Future<Either<Failures, List<TopEventEntity>>> all();
}