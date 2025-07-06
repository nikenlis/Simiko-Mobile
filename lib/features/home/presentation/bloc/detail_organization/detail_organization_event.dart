part of 'detail_organization_bloc.dart';

sealed class DetailOrganizationEvent extends Equatable {
  const DetailOrganizationEvent();

  @override
  List<Object> get props => [];
}

class GetDetailOrganizationEvent extends DetailOrganizationEvent {
  final int id;

  const GetDetailOrganizationEvent({required this.id});
}
