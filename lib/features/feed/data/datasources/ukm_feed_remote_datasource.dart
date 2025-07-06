import 'package:simiko/core/api/api_client.dart';
import 'package:simiko/features/feed/data/models/detail_post_model.dart';
import '../models/detail_event_model.dart';
import '../models/ukm_feed_model.dart';

abstract class UkmFeedRemoteDatasource {
  Future<List<UkmFeedModel>> getAllUkmFeed();
  Future<DetailPostModel> getDetailPost(int id);
  Future<DetailEventModel> getDetailEvent(int id);
}

class UkmFeedRemoteDatasourceImpl implements UkmFeedRemoteDatasource {
  final ApiClient apiClient;

  UkmFeedRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<UkmFeedModel>> getAllUkmFeed() async {
    final response = await apiClient.get('/feed');
    final json = response.data;

    final List<dynamic> postJson = json['data']['feeds']['post'];
    final List<dynamic> eventJson = json['data']['feeds']['event'];
    final List<dynamic> ukmJson = json['data']['ukms'];

    final posts = postJson.map((e) => FeedItemModel.fromJson(e)).toList();
    final events = eventJson.map((e) => FeedItemModel.fromJson(e)).toList();

    return ukmJson.map((ukm) {
      final ukmId = ukm['id'];
      final name = ukm['name'];
      final logoUrl = ukm['logo_url'] ?? '';

      final ukmPosts =
          posts.where((p) => (p).ukmId == ukmId).toList();
      final ukmEvents =
          events.where((e) => (e).ukmId == ukmId).toList();


      return UkmFeedModel(
        id: ukmId,
        name: name,
        logoUrl: logoUrl,
        posts: ukmPosts,
        events: ukmEvents,
      );
    }).toList(growable: false);

  }
  
  @override
  Future<DetailPostModel> getDetailPost(int id) async {
    final response = await apiClient.get('/feed/$id');
    return DetailPostModel.fromJson(response.data['data']);
  }
  
  @override
  Future<DetailEventModel> getDetailEvent(int id) async {
    final response = await apiClient.get('/feed/$id');
    return DetailEventModel.fromJson(response.data['data']);
  }
}
