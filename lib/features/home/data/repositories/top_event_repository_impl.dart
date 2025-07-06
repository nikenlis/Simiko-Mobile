import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/exceptions.dart';
import 'package:simiko/core/error/failures.dart';
import 'package:simiko/features/home/data/datasources/top_event/top_event_local_datasource.dart';
import 'package:simiko/features/home/data/datasources/top_event/top_event_remote_datasource.dart';
import 'package:simiko/features/home/domain/entities/top_event_entity.dart';
import 'package:simiko/features/home/domain/repositories/top_event_repository.dart';

import '../../../../core/platform/network_info.dart';

class TopEventRepositoryImpl implements TopEventRepository{
  final NetworkInfo networkInfo;
  final TopEventLocalDatasource localDatasource;
  final TopEventRemoteDatasource remoteDatasource;

  TopEventRepositoryImpl({required this.networkInfo, required this.localDatasource, required this.remoteDatasource});

  @override
  Future<Either<Failures, List<TopEventEntity>>> all() async {
    bool online = await networkInfo.isConnected();
    if(online) {
      try{
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
  }

