import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../domain/usecases/like_usecase/get_liked_event_usecase.dart';
import '../../../domain/usecases/like_usecase/get_liked_post_usecase.dart';
import '../../../domain/usecases/like_usecase/toggle_event_like_usecase.dart';
import '../../../domain/usecases/like_usecase/toggle_post_like_usecase.dart';
import 'like_state.dart';


class LikeCubit extends Cubit<LikeState> {
  final GetLikedPostUsecase getLikedPosts;
  final GetLikedEventUsecase getLikedEvents;
  final TogglePostLikeUseCase togglePostLike;
  final ToggleEventLikeUseCase toggleEventLike;

  LikeCubit({
    required this.getLikedPosts,
    required this.getLikedEvents,
    required this.togglePostLike,
    required this.toggleEventLike,
  }) : super(const LikeState());

  Future<void> loadLikedContent() async {
    final postResult = await getLikedPosts.execute();
    final eventResult = await getLikedEvents.execute();

    emit(state.copyWith(
      likedPostIds: postResult.getOrElse(() => []),
      likedEventIds: eventResult.getOrElse(() => []),
    ));
  }

  Future<void> toggleLikePost(int id) async {
    final result = await togglePostLike.execute(id);
    result.fold(
      (failure) => print('Error: $failure'),
      (_) => loadLikedContent(),
    );
  }

  Future<void> toggleLikeEvent(int id) async {
    final result = await toggleEventLike.execute(id);
    result.fold(
      (failure) => print('Error: $failure'),
      (_) => loadLikedContent(),
    );
  }

  bool isPostLiked(int id) => state.likedPostIds.contains(id);
  bool isEventLiked(int id) => state.likedEventIds.contains(id);
}
