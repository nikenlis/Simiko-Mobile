import 'package:simiko/features/home/data/models/top_event_model.dart';

import '../../../../../core/api/api_client.dart';

abstract class TopEventRemoteDatasource {
  Future<List<TopEventModel>> all();
}

class TopEventRemoteDatasourceImpl implements TopEventRemoteDatasource {
  final ApiClient apiClient;

  TopEventRemoteDatasourceImpl({required this.apiClient});
  
  @override
  Future<List<TopEventModel>> all() async {
    final response = await apiClient.get('/banner');
     final List<dynamic> rawList = response.data['data'];
  
  final List<TopEventModel> parsedList = rawList
      .map((e) => TopEventModel.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  return parsedList;
  }

}