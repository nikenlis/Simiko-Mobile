import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failures, AuthEntity>> signUp(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String? photo,
      required File? file});

  Future<Either<Failures, String>> signIn(
      {required String email, required String password});

  Future<Either<Failures, String>> checkCredential();
  Future<Either<Failures, Unit>> logout();

}
