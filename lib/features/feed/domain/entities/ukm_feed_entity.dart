import 'package:equatable/equatable.dart';
import 'package:simiko/features/feed/domain/entities/feed_item_entity.dart';

class UkmFeedEntity extends Equatable{
  final int id;
  final String name;
  final String? logoUrl;
  final List<FeedItemEntity> posts;
  final List<FeedItemEntity> events;

  const UkmFeedEntity({required this.id, required this.name, required this.logoUrl, required this.posts, required this.events});
  
  @override
  List<Object?> get props => [id, name, posts, events];
}