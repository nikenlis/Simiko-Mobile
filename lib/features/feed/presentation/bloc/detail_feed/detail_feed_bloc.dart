import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simiko/features/feed/domain/usecases/detail_event_usecase.dart';

import '../../../domain/entities/detail_event_entity.dart';
import '../../../domain/entities/detail_post_entity.dart';
import '../../../domain/usecases/detail_post_usecase.dart';

part 'detail_feed_event.dart';
part 'detail_feed_state.dart';

class DetailFeedBloc extends Bloc<DetailFeedEvent, DetailFeedState> {
  final DetailPostUsecase _usecasePost;
  final DetailEventUsecase _usecaseEvent;
  DetailFeedBloc(this._usecasePost, this._usecaseEvent) : super(DetailFeedInitial()) {
    on<GetDetailPostEvent>((event, emit) async {
      emit(DetailFeedLoading());
      final result = await _usecasePost.execute(id: event.id);
      result.fold(
        (failure) => emit(DetailFeedFailed(message: failure.message)),
        (data) => emit(DetailPostLoaded(data: data))
      );
    });

    on<GetDetailEvent>((event, emit) async {
      emit(DetailFeedLoading());
      final result = await _usecaseEvent.execute(id: event.id);
      result.fold(
        (failure) => emit(DetailFeedFailed(message: failure.message)),
        (data) => emit(DetailEventLoaded(data: data))
      );
    });
  }
}
