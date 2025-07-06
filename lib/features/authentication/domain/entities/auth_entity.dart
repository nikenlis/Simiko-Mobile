import 'dart:io';

import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String name;
  final String email;
  final String? password;
  final String phone;
  final String? token;
  final String? photo;
  final File? file;


  const AuthEntity(
      {required this.email,
      this.password,
      required this.name,
      required this.phone,
      this.token, 
      this.photo,
      this.file
      });

  @override
  List<Object?> get props => [email, password, name, phone, token, photo, file];
}
