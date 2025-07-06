import 'package:shared_preferences/shared_preferences.dart';

const _likedPostsKey = 'liked_posts';
const _likedEventsKey = 'liked_events';

abstract class UkmFeedLocalDatasource {
  Future<List<int>> getLikedPosts();
  Future<List<int>> getLikedEvents();
  Future<void> togglePostLike(int id);
  Future<void> toggleEventLike(int id);
  Future<bool> isPostLiked(int id);
  Future<bool> isEventLiked(int id);
}

class UkmFeedLocalDatasourceImpl extends UkmFeedLocalDatasource {
  final SharedPreferences pref;

  UkmFeedLocalDatasourceImpl({required this.pref});

  @override
  Future<List<int>> getLikedPosts() async {
    return pref.getStringList(_likedPostsKey)?.map(int.parse).toList() ?? [];
  }

  @override
  Future<List<int>> getLikedEvents() async {
    return pref.getStringList(_likedEventsKey)?.map(int.parse).toList() ?? [];
  }

  @override
  Future<void> togglePostLike(int id) async {
    final liked = await getLikedPosts();
    if (liked.contains(id)) {
      liked.remove(id);
    } else {
      liked.add(id);
    }
    await pref.setStringList(
      _likedPostsKey,
      liked.map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<void> toggleEventLike(int id) async {
    final liked = await getLikedEvents();
    if (liked.contains(id)) {
      liked.remove(id);
    } else {
      liked.add(id);
    }
    await pref.setStringList(
      _likedEventsKey,
      liked.map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<bool> isPostLiked(int id) async {
    final liked = await getLikedPosts();
    return liked.contains(id);
  }

  @override
  Future<bool> isEventLiked(int id) async {
    final liked = await getLikedEvents();
    return liked.contains(id);
  }
}
