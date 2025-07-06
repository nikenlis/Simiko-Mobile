import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simiko/features/home/domain/usecases/top_event_usecase.dart';

import '../../../domain/entities/top_event_entity.dart';

part 'top_event_event.dart';
part 'top_event_state.dart';

class TopEventBloc extends Bloc<TopEventEvent, TopEventState> {
  final TopEventUsecase _usecase;
  TopEventBloc(this._usecase) : super(TopEventInitial()) {
    on<GetAllTopEvent>((event, emit) async {
      emit(TopEventLoading());
      final result = await _usecase.execute();
      result.fold(
        (failure) => emit(TopEventFailed(message: failure.message)), 
        (data) => emit(TopEventLoaded(data: data)));
    });
  }
}
