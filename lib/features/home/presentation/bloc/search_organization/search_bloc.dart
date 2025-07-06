import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simiko/features/home/domain/entities/organization_entity.dart';
import 'package:simiko/features/home/domain/usecases/search_organization_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchOrganizationUsecase _usecase;
  SearchBloc(this._usecase) : super(SearchInitial()) {
    on<GetSearchEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await _usecase.execute(query: event.query);
      result.fold((failure) => emit(SearchFailed(message: failure.message)),
       (data) => emit(SearchLoaded(data: data)));
    });

    

    on<GetResetSearchEvent>((event, emit) async {
      emit(SearchInitial());
    });
  }
}
