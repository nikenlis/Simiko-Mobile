
import '../../domain/entities/auth_entity.dart';

class AuthModel {
  final String accessToken;
  final String tokenType;
  UserModel? user;

  AuthModel({
    required this.accessToken,
    required this.tokenType,
    this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      user:
          json['user'] != null ? UserModel.fromJsonSignUp(json['user']) : null,
    );
  }
}

class UserModel extends AuthEntity {
  final int? id;
  final String? createdAt;
  final String? updatedAt;

  const UserModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    required super.name,
    required super.email,
    required super.phone,
    super.password,
    super.photo,
    super.file
  });

  factory UserModel.fromJsonSignUp(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJsonLocal() {
  return {
    'email': email,
    'name': name,
    'phone': phone,
    'photo': photo, 
    'created_at': createdAt,
    'updated_at': updatedAt,
    'id': id,
  };
}

  Map<String, dynamic> toJsonSignIn() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  AuthEntity get toEntity => AuthEntity(
      email: email,
      password: password,
      name: name,
      phone: phone,
      photo: photo
      );
}
