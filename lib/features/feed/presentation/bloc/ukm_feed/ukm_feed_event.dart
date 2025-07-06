part of 'ukm_feed_bloc.dart';

sealed class UkmFeedEvent extends Equatable {
  const UkmFeedEvent();

  @override
  List<Object> get props => [];
}

class GetAllUkmFeedEvent extends UkmFeedEvent {
  
}
