import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:simiko/features/authentication/domain/entities/auth_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class GetSignupUsecase {
  final AuthRepository repository;

  GetSignupUsecase({required this.repository});

  Future<Either<Failures, AuthEntity>> execute(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String? photo,
      required File? file
      }) {
    return repository.signUp(
      password: password,
      email: email,
      name: name,
      phone: phone,
      photo: photo,
      file: file
    );
  }
}
