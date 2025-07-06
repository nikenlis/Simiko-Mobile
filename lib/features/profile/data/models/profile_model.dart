import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.photoUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photo_url'],
    );
  }

  ProfileEntity get toEntity => ProfileEntity(id: id, name: name, email: email, phone: phone, photoUrl: photoUrl);
}
