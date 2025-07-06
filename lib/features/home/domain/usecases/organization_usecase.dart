import 'package:dartz/dartz.dart';
import 'package:simiko/features/home/domain/entities/organization_entity.dart';
import 'package:simiko/features/home/domain/repositories/organization_repository.dart';

import '../../../../core/error/failures.dart';


class OrganizationUsecase {
  final OrganizationRepository repository;

  OrganizationUsecase({required this.repository});

  Future<Either<Failures, List<OrganizationEntity>>> execute (){
    return repository.all();
  }

}