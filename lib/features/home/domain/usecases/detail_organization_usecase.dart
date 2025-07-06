import 'package:dartz/dartz.dart';
import 'package:simiko/features/home/domain/entities/detail_organization/detail_organization_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/organization_repository.dart';

class DetailOrganizationUsecase {
  final OrganizationRepository repository;

  DetailOrganizationUsecase({required this.repository});
  
  Future<Either<Failures, DetailOrganizationEntity>> execute ({required int id}){
    return repository.detailOrganization(id: id);
  }
}