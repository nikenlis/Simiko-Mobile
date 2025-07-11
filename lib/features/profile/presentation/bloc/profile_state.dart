part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();  

  @override
  List<Object> get props => [];
}
class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileFailed extends ProfileState {
  final String message;

  const ProfileFailed({required this.message});
}
class ProfileLoaded extends ProfileState {
  final ProfileEntity data;

  const ProfileLoaded({required this.data});

}

