import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simiko/core/api/api_config.dart';

import '../common/app_route.dart';
import '../common/global_context.dart';
import '../error/exceptions.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({required String baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConfig.BASE_URL,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Accept': 'application/json',
          },
        )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          
          // Tambah header Authorization kalau ada token dan bukan login/register
          if (token != null &&
              !options.path.contains('/login') &&
              !options.path.contains('/register')) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          if (kDebugMode) {
            print("📤 REQUEST [${options.method}] => PATH: ${options.path}");
            print("📦 DATA: ${options.data}");
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print("✅ RESPONSE [${response.statusCode}] => ${response.data}");
          }
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;

          if (kDebugMode) {
            print("❌ ERROR TYPE: ${error.type}");
            print("❌ STATUS CODE: ${error.response?.statusCode}");
            print("❌ ERROR MESSAGE: ${error.message}");
            print("❌ RESPONSE DATA: ${error.response?.data}");
          }

          // 🧠 Tangani error koneksi dan timeout
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.sendTimeout:
            case DioExceptionType.receiveTimeout:
              throw TimeoutException(message: "Connection Timeout");
            case DioExceptionType.badCertificate:
            case DioExceptionType.connectionError:
              _redirectToOfflinePage();
              throw SocketException(message: "No Internet Connection");
            case DioExceptionType.cancel:
              throw Exception("Request Cancelled");
            case DioExceptionType.unknown:
              if (error.error is SocketException) {
                throw SocketException(message: "No Internet Connection");
              } else {
                throw Exception("Unknown Network Error");
              }
            case DioExceptionType.badResponse:
              // Lanjutkan ke pengecekan status code di bawah
              break;
          }

          // 🧾 Tangani status code
          if (statusCode == 400) {
            throw BadRequestException(
                message: data?['message'] ?? 'Bad Request');
          } else if (statusCode == 401) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('token');
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoute.signInPage,
              (route) => false,
            );
                        throw UnauthorizedException(
                message: data?['message'] ?? 'Unauthorized');
          } else if (statusCode == 403) {
            throw ForbiddenException(message: data?['message'] ?? 'Forbidden');
          } else if (statusCode == 404) {
            throw NotFoundException(message: data?['message'] ?? 'Not Found');
          } else if (statusCode == 500) {
            throw ServerException(
                message: data?['message'] ?? 'Internal Server Error');
          } else {
            print(data?['message']);
            throw UnknownException(
                message: data?['message'] ?? 'Unexpected Error');
          }
        },
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> postMultipart(String path, {required FormData data}) {
    return _dio.post(
      path,
      data: data,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );
  }

  void _redirectToOfflinePage() {
  final navigator = navigatorKey.currentState;
  if (navigator != null) {
    navigator.pushNamedAndRemoveUntil(
      AppRoute.offlinePage,
      (route) => false,
    );
  }
}
}
