import 'package:simiko/core/api/api_client.dart';
import 'package:simiko/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final ApiClient apiClient;

  ProfileRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<ProfileModel> getProfile() async {
    final response =  await apiClient.get('/user/profile');
    return ProfileModel.fromJson(response.data['data']);
  }

}