import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/failures.dart';
import 'package:simiko/features/home/domain/entities/detail_organization/detail_organization_entity.dart';
import 'package:simiko/features/home/domain/entities/organization_entity.dart';

abstract class OrganizationRepository {
  Future<Either<Failures, List<OrganizationEntity>>> all();
  Future<Either<Failures, List<OrganizationEntity>>> search({required String query});
  Future<Either<Failures, DetailOrganizationEntity>> detailOrganization({required int id});
}