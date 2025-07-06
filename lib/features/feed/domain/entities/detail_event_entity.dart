import 'package:equatable/equatable.dart';

class DetailEventEntity extends Equatable {
  final int id;
  final String type;
  final String title;
  final String? content;
  final String? imageUrl;
  final String ukmName;
  final String ukmAlias;
  final String ukmLogoUrl;
  final String createdAt;
  final String eventDate;
  final String? eventType;
  final String? location;
  final bool isPaid;
  final String? amount;
  final String? link;

  const DetailEventEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.ukmName,
    required this.ukmAlias,
    required this.ukmLogoUrl,
    required this.createdAt,
    required this.eventDate,
    required this.eventType,
    required this.location,
    required this.isPaid,
    required this.amount,
    required this.link,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        content,
        imageUrl,
        ukmName,
        ukmAlias,
        ukmLogoUrl,
        createdAt,
        eventDate,
        eventType,
        location,
        isPaid,
        amount,
        link,
      ];
}

