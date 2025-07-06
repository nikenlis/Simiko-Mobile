part of 'top_event_bloc.dart';

sealed class TopEventEvent extends Equatable {
  const TopEventEvent();

  @override
  List<Object> get props => [];
}

class GetAllTopEvent extends TopEventEvent {}
