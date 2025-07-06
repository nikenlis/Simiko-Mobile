part of 'detail_feed_bloc.dart';

sealed class DetailFeedEvent extends Equatable {
  const DetailFeedEvent();

  @override
  List<Object> get props => [];
}

class GetDetailPostEvent extends DetailFeedEvent {
  final int id;

  const GetDetailPostEvent({required this.id});

}


class GetDetailEvent extends DetailFeedEvent {
  final int id;

  const GetDetailEvent({required this.id});

}
