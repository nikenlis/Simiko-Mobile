import 'package:simiko/features/home/domain/entities/organization_entity.dart';

class OrganizationModel extends OrganizationEntity {
  OrganizationModel(
      {required super.id,
      required super.name,
      required super.alias,
      required super.category,
      required super.logo,
      required super.description});

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json["id"],
      name: json["name"],
      alias: json["alias"],
      category: json["category"],
      logo: json["logo"],
      description: json["description"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alias": alias,
        "category": category,
        "logo": logo,
        "description": description,
      };
  OrganizationEntity get toEntity => OrganizationEntity(
      id: id,
      name: name,
      alias: alias,
      category: category,
      logo: logo,
      description: description);
}
