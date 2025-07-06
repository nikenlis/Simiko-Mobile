import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simiko/features/home/domain/usecases/detail_organization_usecase.dart';

import '../../../domain/entities/detail_organization/detail_organization_entity.dart';

part 'detail_organization_event.dart';
part 'detail_organization_state.dart';

class DetailOrganizationBloc
    extends Bloc<DetailOrganizationEvent, DetailOrganizationState> {
  final DetailOrganizationUsecase _usecase;
  DetailOrganizationBloc(this._usecase) : super(DetailOrganizationInitial()) {
    on<GetDetailOrganizationEvent>((event, emit) async {
      emit(DetailOrganizationLoading());
      final result = await _usecase.execute(id: event.id);
      result.fold(
          (failure) => emit(DetailOrganizationFailed(message: failure.message)),
          (data) => emit(DetailOrganizationLoaded(data: data)));
    });
  }
}
