part of 'ukm_feed_bloc.dart';

sealed class UkmFeedState extends Equatable {
  const UkmFeedState();
  
  @override
  List<Object> get props => [];
}

final class UkmFeedInitial extends UkmFeedState {}
final class UkmFeedLoading extends UkmFeedState {}
final class UkmFeedFailed extends UkmFeedState {
  final String message;

  const UkmFeedFailed({required this.message});

}
final class UkmFeedLoaded extends UkmFeedState {
  final List<UkmFeedEntity> data;

  const UkmFeedLoaded({required this.data});
}

