import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:simiko/core/error/failures.dart';
import 'package:simiko/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:simiko/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:simiko/features/authentication/data/models/auth_model.dart';
import 'package:simiko/features/authentication/domain/entities/auth_entity.dart';
import 'package:simiko/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthLocalDatasource localDatasource;
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(
      {required this.networkInfo,
      required this.localDatasource,
      required this.remoteDatasource});

  @override
  Future<Either<Failures, String>> signIn(
      {required email, required String password}) async {
    bool online = await networkInfo.isConnected();

    if (online) {
      try {
        final token = await remoteDatasource.signIn(UserModel(
            name: '',
            email: email,
            phone: '',
            password: password));
        await localDatasource.cachedToken(token);
        return Right(token);
      } on TimeoutException {
        return const Left(NotFoundFailure('Timeout. No Response'));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerException {
        return const Left(ServerFailure('Server Error'));
      } on SocketException {
        return const Left(ConnectionFailure('Failed connect to the network'));
      } catch (e) {
        print({'DEBUG WEYY $e'});
        return const Left(ServerFailure('Something Went Wrong'));
      }
    } else {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failures, AuthEntity>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String? photo,
    required File? file,
  }) async {
    bool online = await networkInfo.isConnected();

    if (online) {
      try {
        final auth = await remoteDatasource.signUp(UserModel(
            name: name,
            email: email,
            phone: phone,
            password: password,
            file: file));
        await localDatasource.cachedUser(auth.user!);
        await localDatasource.cachedToken(auth.accessToken);
        return Right(auth.user!.toEntity);
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
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failures, String>> checkCredential() async {
    try {
      final token = await localDatasource.getToken();
      return Right(token);
    } on CachedExcaption catch (e) {
      return Left(CachedFailure(e.message.toString()));
    } catch (e) {
      return const Left(ServerFailure('Something Went Wrong'));
    }
  }
  
  @override
  Future<Either<Failures, Unit>> logout() async {
    try {
      await remoteDatasource.logout();
      await localDatasource.removeToken();
      return Right(unit);
    } on CachedExcaption catch (e) {
      return Left(CachedFailure(e.message.toString()));
    } catch (e) {
      return const Left(ServerFailure('Something Went Wrong'));
    }
  }
}
