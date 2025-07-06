import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simiko/features/profile/domain/entities/profile_entity.dart';

import '../../domain/usecases/profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase _usecase;
  ProfileBloc(this._usecase) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final result = await _usecase.execute();
      result.fold(
        (failure) => emit(ProfileFailed(message: failure.message)),
        (data) => emit(ProfileLoaded(data: data))
      );
    });
  }
}
