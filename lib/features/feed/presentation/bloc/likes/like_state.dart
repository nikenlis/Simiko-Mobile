import 'package:equatable/equatable.dart';

class LikeState extends Equatable {
  final List<int> likedPostIds;
  final List<int> likedEventIds;
    final bool isLoading;
  final String? errorMessage;

  const LikeState({
    this.likedPostIds = const [],
    this.likedEventIds = const [],
        this.isLoading = false,
    this.errorMessage,
  });

  LikeState copyWith({
    List<int>? likedPostIds,
    List<int>? likedEventIds,
        bool? isLoading,
    String? errorMessage,
  }) {
    return LikeState(
      likedPostIds: likedPostIds ?? this.likedPostIds,
      likedEventIds: likedEventIds ?? this.likedEventIds,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [likedPostIds, likedEventIds];
}
