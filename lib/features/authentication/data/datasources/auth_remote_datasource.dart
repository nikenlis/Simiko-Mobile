import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:simiko/core/api/api_client.dart';
import 'package:simiko/features/authentication/data/models/auth_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> signUp(UserModel user);
  Future<String> signIn(UserModel user);
  Future<Unit> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient apiClient;

  AuthRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<String> signIn(UserModel user) async {
    final response = await apiClient.post('/login', data: user.toJsonSignIn());
    return response.data['data']['access_token'];
  }

  @override
  Future<AuthModel> signUp(UserModel user) async {
    final mimeType = lookupMimeType(user.file!.path) ?? 'image/jpeg';
    final mediaType = MediaType.parse(mimeType);

    final formData = FormData.fromMap({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'password': user.password,
      'img_photo': await MultipartFile.fromFile(
        user.file!.path,
        filename: user.file!.path.split('/').last,
        contentType: mediaType,
      ),
    });
   final response = await apiClient.postMultipart('/register', data: formData);
    return AuthModel.fromJson(response.data['data']);
  }
  
  @override
  Future<Unit> logout() async {
    await apiClient.post('/logout');
    return unit;
  }
}
