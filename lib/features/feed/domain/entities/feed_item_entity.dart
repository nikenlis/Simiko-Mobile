import 'package:equatable/equatable.dart';

class FeedItemEntity extends Equatable {
  final int id;
  final String? type;
  final String? title;
  final String? imageUrl;
  final DateTime createdAt;

  const FeedItemEntity(
      {required this.id,
      required this.type,
      required this.title,
      required this.imageUrl,
      required this.createdAt});

  @override
  List<Object?> get props => [id, type, title, imageUrl, createdAt];
}
