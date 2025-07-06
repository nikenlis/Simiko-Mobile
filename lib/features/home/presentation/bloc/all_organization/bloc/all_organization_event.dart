part of 'all_organization_bloc.dart';

sealed class AllOrganizationEvent extends Equatable {
  const AllOrganizationEvent();

  @override
  List<Object> get props => [];
}

class GetAllOrganizationEvent extends AllOrganizationEvent {
  
}