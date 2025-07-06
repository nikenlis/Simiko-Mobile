import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/failures.dart';
import 'package:simiko/features/home/domain/repositories/organization_repository.dart';

import '../entities/organization_entity.dart';

class SearchOrganizationUsecase {
  final OrganizationRepository repository;
  SearchOrganizationUsecase({required this.repository});

  Future<Either<Failures, List<OrganizationEntity>>> execute({required String query}){
    return repository.search(query: query);
  }
  }