part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();  

  @override
  List<Object> get props => [];
}
class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchFailed extends SearchState {
  final String message;

  const SearchFailed({required this.message});

}
class SearchLoaded extends SearchState {
  final List<OrganizationEntity> data;

  const SearchLoaded({required this.data});
}
