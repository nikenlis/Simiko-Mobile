part of 'top_event_bloc.dart';

sealed class TopEventState extends Equatable {
  const TopEventState();
  
  @override
  List<Object> get props => [];
}

final class TopEventInitial extends TopEventState {}
final class TopEventLoading extends TopEventState {}
final class TopEventFailed extends TopEventState {
  final String message;

  const TopEventFailed({required this.message});

}
final class TopEventLoaded extends TopEventState {
  final List<TopEventEntity> data;

  const TopEventLoaded({required this.data});

}