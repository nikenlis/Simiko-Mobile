import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simiko/features/home/data/models/organization_model.dart';

import '../../../../../core/error/exceptions.dart';

const cacheOrganizationKey = 'organization';

abstract class OrganizationLocalDatasource {
  Future<List<OrganizationModel>> getAll();
  Future<bool> cachedAll(List<OrganizationModel> list);
}

class OrganizationLocalDatasourceImpl implements OrganizationLocalDatasource {
  final SharedPreferences pref;

  OrganizationLocalDatasourceImpl({required this.pref});
  @override
  Future<bool> cachedAll(List<OrganizationModel> list) {
    List<Map<String, dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allOrgazation = jsonEncode(listMap);
    return pref.setString(cacheOrganizationKey, allOrgazation);
  }

  @override
  Future<List<OrganizationModel>> getAll() async {
    String? allOrgazation = pref.getString(cacheOrganizationKey);
    if(allOrgazation != null) {
      List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>.from(jsonDecode(allOrgazation));
      List<OrganizationModel> list =  listMap.map((e) => OrganizationModel.fromJson(e)).toList();
      return list;
    } 
    throw CachedExcaption(message: 'Data tidak ditemukan');
  }

}