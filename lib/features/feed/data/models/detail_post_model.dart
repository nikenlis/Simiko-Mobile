import 'package:simiko/features/feed/domain/entities/detail_post_entity.dart';

class DetailPostModel extends DetailPostEntity {
  const DetailPostModel(
      {required super.id,
      required super.type,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.ukmId,
      required super.ukmName,
      required super.ukmAlias,
      required super.ukmLogoUrl,
      required super.createdAt});

  factory DetailPostModel.fromJson(Map<String, dynamic> json) {
    return DetailPostModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'] ?? '',
      ukmId: json['ukm']?['id'] ?? 0,
      ukmName: json['ukm']?['name'] ?? '',
      ukmAlias: json['ukm']?['alias'] ?? '',
      ukmLogoUrl: json['ukm']?['logo_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  DetailPostEntity get toEntity => DetailPostEntity(
      id: id,
      type: type,
      title: title,
      content: content,
      imageUrl: imageUrl,
      ukmId: ukmId,
      ukmName: ukmName,
      ukmAlias: ukmAlias,
      ukmLogoUrl: ukmLogoUrl,
      createdAt: createdAt);
}
