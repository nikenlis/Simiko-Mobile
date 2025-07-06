import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/exceptions.dart';
import 'package:simiko/core/error/failures.dart';
import 'package:simiko/core/platform/network_info.dart';
import 'package:simiko/features/home/data/datasources/organization/organization_local_datasource.dart';
import 'package:simiko/features/home/data/datasources/organization/organization_remote_datasource.dart';
import 'package:simiko/features/home/domain/entities/detail_organization/detail_organization_entity.dart';
import 'package:simiko/features/home/domain/entities/organization_entity.dart';
import 'package:simiko/features/home/domain/repositories/organization_repository.dart';

class OrganizationRepositoryImpl implements OrganizationRepository {
  final NetworkInfo networkInfo;
  final OrganizationLocalDatasource localDatasource;
  final OrganizationRemoteDatasource remoteDatasource;

  OrganizationRepositoryImpl(
      {required this.networkInfo,
      required this.localDatasource,
      required this.remoteDatasource});

  @override
  Future<Either<Failures, List<OrganizationEntity>>> all() async {
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDatasource.all();
        await localDatasource.cachedAll(result);
        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return const Left(NotFoundFailure('Timeout. No Response'));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerException {
        return const Left(ServerFailure('Server Error'));
      } on SocketException {
        return const Left(ConnectionFailure('Failed connect to the network'));
      } catch (e) {
        return const Left(ServerFailure('Something Went Wrong'));
      }
    } else {
      try {
        final result = await localDatasource.getAll();
        return Right(result.map((e) => e.toEntity).toList());
      } on CachedExcaption {
        return const Left(CachedFailure('Data is not Present'));
      }
    }
  }

  @override
  Future<Either<Failures, List<OrganizationEntity>>> search(
      {required String query}) async {
    try {
      final result = await remoteDatasource.search(query);
      return Right(result.map((e) => e.toEntity).toList());
    } on TimeoutException {
      return const Left(NotFoundFailure('Timeout. No Response'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message.toString()));
    } on ServerException {
      return const Left(ServerFailure('Server Error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to the network'));
    } catch (e) {
      return const Left(ServerFailure('Something Went Wrong'));
    }
  }

  @override
  Future<Either<Failures, DetailOrganizationEntity>> detailOrganization(
      {required int id}) async {
    try {
      final result = await remoteDatasource.detailOrganization(id);
      return Right(result.toEntity);
    } on TimeoutException {
      return const Left(NotFoundFailure('Timeout. No Response'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message.toString()));
    } on ServerException {
      return const Left(ServerFailure('Server Error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to the network'));
    } catch (e) {
      print("EROR APALAGI : ${e.toString()}");
      return const Left(ServerFailure('Something Went Wrong'));
    }
  }
}
