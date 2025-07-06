import 'package:simiko/features/home/data/models/organization_model.dart';

import '../../../../../core/api/api_client.dart';
import '../../models/detail_organization_model.dart';

abstract class OrganizationRemoteDatasource {
  Future<List<OrganizationModel>> all();
  Future<List<OrganizationModel>> search(String query);
  Future<DetailOrganizationModel> detailOrganization(int id);
}

class OrganizationRemoteDatasourceImpl implements OrganizationRemoteDatasource {
  final ApiClient apiClient;

  OrganizationRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<List<OrganizationModel>> all() async {
    final response = await apiClient.get('/ukms');
    final List<dynamic> rawList = response.data['data'];

    final List<OrganizationModel> parsedList = rawList
        .map((e) => OrganizationModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return parsedList;
  }

  @override
  Future<List<OrganizationModel>> search(String query) async {
    final response = await apiClient.get(
      '/ukms/search',
      queryParameters: {
        'q': query,
      },
    );
    final List<dynamic> rawList = response.data['data'];

    final List<OrganizationModel> parsedList = rawList
        .map((e) => OrganizationModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return parsedList;
  }

  @override
  Future<DetailOrganizationModel> detailOrganization(int id) async {
    final response = await apiClient.get('/ukm/$id/profile-full');
    return DetailOrganizationModel.fromJson(response.data['data']);
  }
}
