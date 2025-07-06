import 'package:equatable/equatable.dart';
import 'package:simiko/features/home/domain/entities/detail_organization/recent_post_entity.dart';

import 'achievement_entity.dart';

class DetailOrganizationEntity extends Equatable {
  final int id;
  final String name;
  final String alias;
  final String category;
  final String profileImageUrl;
  final String description;
  final String visionMission;
  final String? backgroundPhotoUrl;

  final List<AchievementEntity> achievements;
  final List<RecentPostEntity> recentPosts;
  final List<String> activityGallery;

  const DetailOrganizationEntity(
      {required this.id,
      required this.name,
      required this.alias,
      required this.category,
      required this.profileImageUrl,
      required this.description,
      required this.visionMission,
      required this.backgroundPhotoUrl,
      required this.achievements,
      required this.recentPosts,
      required this.activityGallery});

  @override
  List<Object?> get props => [
        id,
        name,
        alias,
        category,
        profileImageUrl,
        description,
        visionMission,
        backgroundPhotoUrl,
        achievements,
        recentPosts,
        activityGallery
      ];
}
