import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simiko/core/error/exceptions.dart';
import 'package:simiko/features/authentication/data/models/auth_model.dart';

const cacheTokenKey = 'token';
const cacheUserKey = 'user';

abstract class AuthLocalDatasource {
  Future<UserModel> getUser();
  Future<bool> cachedUser(UserModel userModel);

  Future<String> getToken();
  Future<bool> cachedToken(String token);
  Future<void> removeToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences pref;

  AuthLocalDatasourceImpl({required this.pref});

  @override
  Future<bool> cachedToken(String token) {
    return pref.setString(cacheTokenKey, token);
  }

  @override
  Future<bool> cachedUser(UserModel userModel) async {
    String user = jsonEncode(userModel.toJsonLocal());
    return pref.setString(cacheUserKey, user);
  }

  @override
  Future<UserModel> getUser() async {
    String? user = pref.getString(cacheUserKey);
    if (user != null) {
      final Map<String, dynamic> userMap = jsonDecode(user);
      return UserModel.fromJsonSignUp(userMap);
    }
    throw CachedExcaption(message: 'User tidak ditemukan di cache');
  }

  @override
  Future<String> getToken() async {
    String? token = pref.getString(cacheTokenKey);
    if (token != null) {
      return token;
    } else {
      throw Exception('Token tidak ditemukan di cache');
    }
  }

  @override
  Future<void> removeToken() async {
    await pref.remove(cacheTokenKey);
    await pref.remove(cacheUserKey);
  }
}
