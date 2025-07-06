import 'package:simiko/features/feed/domain/entities/feed_item_entity.dart';

import '../../domain/entities/ukm_feed_entity.dart';

class UkmFeedModel extends UkmFeedEntity {
  const UkmFeedModel({
    required super.id,
    required super.name,
    required super.logoUrl,
    required List<FeedItemModel> super.posts,
    required List<FeedItemModel> super.events,
  });

  UkmFeedEntity toEntity() {
    return UkmFeedEntity(
      id: id,
      name: name,
      logoUrl: logoUrl,
      posts: posts.map((e) => (e as FeedItemModel).toEntity).toList(),
      events: events.map((e) => (e as FeedItemModel).toEntity).toList(),
    );
  }
}

class FeedItemModel extends FeedItemEntity {
  final int ukmId;

  const FeedItemModel({
    required super.id,
    required super.type ,
    required super.title,
    required super.imageUrl,
    required super.createdAt,
    required this.ukmId,
  });

  factory FeedItemModel.fromJson(Map<String, dynamic> json) {
    return FeedItemModel(
      id: json['id'],
      type: json['type'] as String?,
      title: json['title'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      ukmId: json['ukm']['id'],
    );
  }

  FeedItemEntity get toEntity => FeedItemEntity(
      id: id,
      type: type,
      title: title,
      imageUrl: imageUrl,
      createdAt: createdAt);
}
