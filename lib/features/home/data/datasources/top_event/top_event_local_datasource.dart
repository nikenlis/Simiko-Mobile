import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simiko/core/error/exceptions.dart';
import 'package:simiko/features/home/data/models/top_event_model.dart';

const cacheTopEventKey = 'top_event';

abstract class TopEventLocalDatasource {
  Future<List<TopEventModel>> getAll();
  Future<bool> cachedAll(List<TopEventModel> list);
}

class TopEventLocalDatasourceImpl implements TopEventLocalDatasource {
  final SharedPreferences pref;

  TopEventLocalDatasourceImpl({required this.pref});
  @override
  Future<List<TopEventModel>> getAll() async {
    String? allTopEvent = pref.getString(cacheTopEventKey);
    if(allTopEvent != null) {
      List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>.from(jsonDecode(allTopEvent));
      List<TopEventModel> list = listMap.map((e) => TopEventModel.fromJson(e)).toList();
      return list;
    }
    throw CachedExcaption(message: 'Data tidak ditemukan');
  }
  
  @override
  Future<bool> cachedAll(List<TopEventModel> list) async {
    List<Map<String, dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allTopEvent = jsonEncode(listMap);
    return pref.setString(cacheTopEventKey, allTopEvent);
  }

}