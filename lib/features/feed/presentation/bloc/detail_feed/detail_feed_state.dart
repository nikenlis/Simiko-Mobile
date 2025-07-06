part of 'detail_feed_bloc.dart';

sealed class DetailFeedState extends Equatable {
  const DetailFeedState();
  
  @override
  List<Object> get props => [];
}

final class DetailFeedInitial extends DetailFeedState {}
final class DetailFeedLoading extends DetailFeedState {}
final class DetailFeedFailed extends DetailFeedState {
  final String message;

  const DetailFeedFailed({required this.message});

}
final class DetailPostLoaded extends DetailFeedState {
  final DetailPostEntity data;

  const DetailPostLoaded({required this.data});
}

final class DetailEventLoaded extends DetailFeedState {
  final DetailEventEntity data;

  const DetailEventLoaded({required this.data});
}
