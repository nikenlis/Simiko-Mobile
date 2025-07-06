import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [id, name, email, phone, photoUrl];
}
