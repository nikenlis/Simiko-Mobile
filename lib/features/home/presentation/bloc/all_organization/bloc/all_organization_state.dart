part of 'all_organization_bloc.dart';

sealed class AllOrganizationState extends Equatable {
  const AllOrganizationState();
  
  @override
  List<Object> get props => [];
}

final class AllOrganizationInitial extends AllOrganizationState {}
final class AllOrganizationLoading extends AllOrganizationState {}
final class AllOrganizationFailed extends AllOrganizationState {
  final String message;

  const AllOrganizationFailed({required this.message});

}
final class AllOrganizationLoaded extends AllOrganizationState {
  final List<OrganizationEntity> data;

  const AllOrganizationLoaded({required this.data});

}
