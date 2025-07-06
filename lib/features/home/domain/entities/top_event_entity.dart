import 'package:equatable/equatable.dart';

class TopEventEntity extends Equatable{
  final int id;
  final int feedId;
  final String imageUrl;
  final String ukm;

  const TopEventEntity({required this.id, required this.feedId, required this.imageUrl, required this.ukm});

  @override
  List<Object?> get props => [id, feedId, imageUrl, ukm];
}