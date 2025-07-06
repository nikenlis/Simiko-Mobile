import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simiko/features/feed/domain/usecases/ukm_feed_usecase.dart';

import '../../../domain/entities/ukm_feed_entity.dart';

part 'ukm_feed_event.dart';
part 'ukm_feed_state.dart';

class UkmFeedBloc extends Bloc<UkmFeedEvent, UkmFeedState> {
  final UkmFeedUsecase _usecase;
  UkmFeedBloc(this._usecase) : super(UkmFeedInitial()) {
    on<GetAllUkmFeedEvent>((event, emit) async {
      emit(UkmFeedLoading());
      final result = await _usecase.execute();
      result.fold(
        (failure) => emit(UkmFeedFailed(message: failure.message)),
        (data) => emit(UkmFeedLoaded(data: data))
      );
    });
  }
}
