import 'package:equatable/equatable.dart';

class OrganizationEntity extends Equatable{
    final int id;
    final String name;
    final String alias;
    final String category;
    final String logo;
    final String description;

  const OrganizationEntity({required this.id, required this.name, required this.alias, required this.category, required this.logo, required this.description});

  

  @override
  List<Object> get props => [id,name, alias, category, logo, description];
}