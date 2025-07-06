import 'package:simiko/features/home/domain/entities/detail_organization/detail_organization_entity.dart';

import '../../domain/entities/detail_organization/achievement_entity.dart';
import '../../domain/entities/detail_organization/recent_post_entity.dart';

class DetailOrganizationModel extends DetailOrganizationEntity {
  const DetailOrganizationModel(
      {required super.id,
      required super.name,
      required super.alias,
      required super.category,
      required super.profileImageUrl,
      required super.description,
      required super.visionMission,
      required super.backgroundPhotoUrl,
      required super.achievements,
      required super.recentPosts,
      required super.activityGallery});

  factory DetailOrganizationModel.fromJson(Map<String, dynamic> json) {
    return DetailOrganizationModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        alias: json["alias"] ?? '',
        category: json["category"] ?? '',
        profileImageUrl: json["profile_image_url"] ?? '',
        description: json["description"] ?? '',
        visionMission: json["vision_mission"] ?? '',
        backgroundPhotoUrl: json["background_photo_url"] ?? '',
        achievements: json["achievements"] == null
            ? []
            : List<AchievementModel>.from(
                json["achievements"]!.map((x) => AchievementModel.fromJson(x))),
        recentPosts: json["recent_posts"] == null
            ? []
            : List<RecentPostModel>.from(
                json["recent_posts"]!.map((x) => RecentPostModel.fromJson(x))),
        activityGallery: (json["activity_gallery"] as List<dynamic>?)
    ?.map((x) => x.toString())
    .toList() ?? []
              );
  }

  DetailOrganizationEntity get toEntity => DetailOrganizationEntity(
      id: id,
      name: name,
      alias: alias,
      category: category,
      profileImageUrl: profileImageUrl,
      description: description,
      visionMission: visionMission,
      backgroundPhotoUrl: backgroundPhotoUrl,
      achievements: achievements,
      recentPosts: recentPosts,
      activityGallery: activityGallery);
}

class AchievementModel extends AchievementEntity {
  AchievementModel({required super.title, required super.imageUrl, required super.description});

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      title: json["title"],
      description: json["description"],
      imageUrl: json["image_url"],
    );
  }

  AchievementEntity get toEntity =>
      AchievementEntity(title: title, imageUrl: imageUrl, description: description);
}

class RecentPostModel extends RecentPostEntity {
     RecentPostModel( {required super.title, required super.type, required super.imageUrl, required super.createdAt, required super.id});

  factory RecentPostModel.fromJson(Map<String, dynamic> json) {
    return RecentPostModel(
      id: json["id"],
      title: json["title"],
      type: json["type"],
      imageUrl: json["image_url"],
      createdAt: json["created_at"]
    );
  }

  RecentPostEntity get toEntity =>
      RecentPostEntity(id: id, title: title, type: type, imageUrl: imageUrl, createdAt: createdAt);
}
