import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/failures.dart';
import 'package:simiko/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:simiko/features/profile/domain/entities/profile_entity.dart';
import 'package:simiko/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/exceptions.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failures, ProfileEntity>> getProfile() async {
    try {
      final result = await remoteDatasource.getProfile();
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
      return const Left(ServerFailure('Something Went Wrong'));
    }
  }
}