import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/failures.dart';
import 'package:simiko/features/feed/data/datasources/ukm_feed_local_datasource.dart';
import 'package:simiko/features/feed/data/datasources/ukm_feed_remote_datasource.dart';
import 'package:simiko/features/feed/domain/entities/detail_event_entity.dart';
import 'package:simiko/features/feed/domain/entities/detail_post_entity.dart';
import 'package:simiko/features/feed/domain/entities/ukm_feed_entity.dart';
import 'package:simiko/features/feed/domain/repositories/ukm_feed_repository.dart';

import '../../../../core/error/exceptions.dart';

class UkmFeedRepositoryImpl implements UkmFeedRepository {
  final UkmFeedRemoteDatasource remoteDatasource;
  final UkmFeedLocalDatasource localDatasource;

  UkmFeedRepositoryImpl({required this.localDatasource, required this.remoteDatasource});
  @override
  Future<Either<Failures, List<UkmFeedEntity>>> ukmFeed() async {
    try {
      final result = await remoteDatasource.getAllUkmFeed();
      return Right(result.map((e) => e.toEntity()).toList());
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
  Future<Either<Failures, DetailPostEntity>> detailPost(
      {required int id}) async {
    try {
      final result = await remoteDatasource.getDetailPost(id);
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
      print("📦📦📦 POSTT Response Data: ${e.toString()}");
      return const Left(ServerFailure('Something Went Wrong'));
    }
  }

    @override
  Future<Either<Failures, DetailEventEntity>> detailEvent({required int id}) async {
    try {
      final result = await remoteDatasource.getDetailEvent(id);
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
      print("📦📦📦EVENT Response Data: ${e.toString()}");
      return const Left(ServerFailure('Something Went Wrong'));
    }
  }
  
  @override
  Future<Either<Failures, List<int>>> getLikedEvents() async {
    try {
    final result = await localDatasource.getLikedEvents();
    return Right(result);
  } catch (e) {
    return const Left(ServerFailure('Failed to retrieve liked events'));
  }
  }
  
  @override
  Future<Either<Failures, List<int>>> getLikedPosts() async {
    try {
    final result = await localDatasource.getLikedPosts();
    return Right(result);
  } catch (e) {
    return const Left(ServerFailure('Failed to retrieve liked events'));
  }
  }
  
  @override
  Future<Either<Failures, bool>> isEventLiked(int id) async {
    try {
    final result = await localDatasource.isEventLiked(id);
    return Right(result);
  } catch (e) {
    return const Left(ServerFailure('Failed to check liked event'));
  }
  }
  
  @override
  Future<Either<Failures, bool>> isPostLiked(int id) async {
    try {
    final result = await localDatasource.isPostLiked(id);
    return Right(result);
  } catch (e) {
    return const Left(ServerFailure('Failed to check liked post'));
  }
  }
  
  @override
  Future<Either<Failures, void>> toggleEventLike(int id) async {
    try {
    await localDatasource.toggleEventLike(id);
    return const Right(null);
  } catch (e) {
    return const Left(ServerFailure('Failed to toggle liked event'));
  }
  }
  
  @override
  Future<Either<Failures, void>> togglePostLike(int id) async {
    try {
    await localDatasource.togglePostLike(id);
    return const Right(null);
  } catch (e) {
    return const Left(ServerFailure('Failed to toggle liked post'));
  }
  }

}
