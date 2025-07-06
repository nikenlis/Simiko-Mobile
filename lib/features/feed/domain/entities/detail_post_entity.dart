import 'package:equatable/equatable.dart';

class DetailPostEntity extends Equatable{
  final int id;
  final String type;
  final String title;
  final String content;
  final String? imageUrl;
  final int ukmId;
  final String ukmName;
  final String ukmAlias;
  final String? ukmLogoUrl;
  final DateTime createdAt;

  const DetailPostEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.ukmId,
    required this.ukmName,
    required this.ukmAlias,
    required this.ukmLogoUrl,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [id, type, title, content, imageUrl, ukmId, ukmName, ukmAlias,ukmLogoUrl, createdAt];
}

