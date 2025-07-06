import 'package:simiko/features/home/domain/entities/top_event_entity.dart';

class TopEventModel extends TopEventEntity {
  const TopEventModel(
      {required super.id,
      required super.feedId,
      required super.imageUrl,
      required super.ukm});

  factory TopEventModel.fromJson(Map<String, dynamic> json) {
    return TopEventModel(
      id: json["id"],
      feedId: json["feed_id"],
      imageUrl: json["image_url"],
      ukm: json["ukm"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "feed_id": feedId,
        "image_url": imageUrl,
        "ukm": ukm,
    };
    
  TopEventEntity get toEntity =>
      TopEventEntity(id: id, feedId: feedId, imageUrl: imageUrl, ukm: ukm);
}
