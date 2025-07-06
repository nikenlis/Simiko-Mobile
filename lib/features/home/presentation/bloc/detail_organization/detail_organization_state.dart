part of 'detail_organization_bloc.dart';

sealed class DetailOrganizationState extends Equatable {
  const DetailOrganizationState();
  
  @override
  List<Object> get props => [];
}

final class DetailOrganizationInitial extends DetailOrganizationState {}
final class DetailOrganizationLoading extends DetailOrganizationState {}
final class DetailOrganizationFailed extends DetailOrganizationState {
  final String message;

  const DetailOrganizationFailed({required this.message});

}
final class DetailOrganizationLoaded extends DetailOrganizationState {
  final DetailOrganizationEntity data;

  const DetailOrganizationLoaded({required this.data});

}