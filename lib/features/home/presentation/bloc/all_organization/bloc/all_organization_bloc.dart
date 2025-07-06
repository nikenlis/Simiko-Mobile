import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simiko/features/home/domain/entities/organization_entity.dart';
import 'package:simiko/features/home/domain/usecases/organization_usecase.dart';

part 'all_organization_event.dart';
part 'all_organization_state.dart';

class AllOrganizationBloc extends Bloc<AllOrganizationEvent, AllOrganizationState> {
  final OrganizationUsecase _usecase;
  AllOrganizationBloc(this._usecase) : super(AllOrganizationInitial()) {
    on<GetAllOrganizationEvent>((event, emit) async {
      emit(AllOrganizationLoading());
      final result = await _usecase.execute();
      result.fold(
        (failure) => emit(AllOrganizationFailed(message: failure.message)), 
        (data) => emit(AllOrganizationLoaded(data: data)));
    });
  }
}
