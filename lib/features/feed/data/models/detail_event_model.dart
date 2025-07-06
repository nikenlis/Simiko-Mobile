import 'package:simiko/features/feed/domain/entities/detail_event_entity.dart';

class DetailEventModel extends DetailEventEntity {
  const DetailEventModel({
    required int id,
    required String type,
    required String title,
    required String content,
    required String imageUrl,
    required String ukmName,
    required String ukmAlias,
    required String ukmLogoUrl,
    required String createdAt,
    required String eventDate,
    required String eventType,
    required String location,
    required bool isPaid,
    required String amount,
    required String link,
  }) : super(
          id: id,
          type: type,
          title: title,
          content: content,
          imageUrl: imageUrl,
          ukmName: ukmName,
          ukmAlias: ukmAlias,
          ukmLogoUrl: ukmLogoUrl,
          createdAt: createdAt,
          eventDate: eventDate,
          eventType: eventType,
          location: location,
          isPaid: isPaid,
          amount: amount,
          link: link,
        );

  factory DetailEventModel.fromJson(Map<String, dynamic> json) {
    final ukm = json['ukm'] ?? {};
    return DetailEventModel(
      id: json['id'],
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['image_url'] ?? '',
      ukmName: ukm['name'] ?? '',
      ukmAlias: ukm['alias'] ?? '',
      ukmLogoUrl: ukm['logo_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      eventDate: json['event_date'] ?? '',
      eventType: json['event_type'] ?? '',
      location: json['location'] ?? '',
      isPaid: json['is_paid'],
      amount: json['amount'] ?? '',
      link: json['link'] ?? '',
    );
  }

  DetailEventEntity get toEntity => DetailEventEntity(
      id: id,
      type: type,
      title: title,
      content: content,
      imageUrl: imageUrl,
      ukmName: ukmName,
      ukmAlias: ukmAlias,
      ukmLogoUrl: ukmLogoUrl,
      createdAt: createdAt,
      eventDate: eventDate,
      eventType: eventType,
      location: location,
      isPaid: isPaid,
      amount: amount,
      link: link);
}
