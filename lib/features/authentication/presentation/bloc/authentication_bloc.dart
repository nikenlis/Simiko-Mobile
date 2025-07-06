import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simiko/features/authentication/domain/entities/auth_entity.dart';
import 'package:simiko/features/authentication/domain/usecases/check_credential_usecase.dart';
import 'package:simiko/features/authentication/domain/usecases/get_signin_usecase.dart';
import 'package:simiko/features/authentication/domain/usecases/logout_usecase.dart';

import '../../domain/usecases/get_signup_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetSignupUsecase _signUpUseCase;
  final GetSigninUsecase _signinUsecase;
  final CheckCredentialUsecase _checkCredentialUsecase;
  final LogoutUsecase _logoutUsecase;
  AuthenticationBloc(
      this._signUpUseCase, this._signinUsecase, this._checkCredentialUsecase, this._logoutUsecase)
      : super(AuthenticationInitial()) {
    on<SignUpAuthEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await _signUpUseCase.execute(
          email: event.email,
          password: event.password,
          name: event.name,
          phone: event.phone,
          file: event.file,
          photo: null);

      result.fold(
          (failure) => emit(AuthenticationFailed(message: failure.message)),
          (data) => emit(AuthenticationSignUpLoaded(data: data)));
    });

    on<SignInAuthEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await _signinUsecase.execute(
          email: event.email, password: event.password);

      result.fold(
          (failure) => emit(AuthenticationFailed(message: failure.message)),
          (data) => emit(AuthenticationSignInLoaded(data: data)));
    });

    on<AuthCheckCredential>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await _checkCredentialUsecase.execute();

      result.fold(
          (failure) => emit(AuthenticationFailed(message: failure.message)),
          (data) => emit(AuthenticationCheckCredentialLoaded()));
    });

    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await _logoutUsecase.execute();
      result.fold(
          (failure) => emit(AuthenticationFailed(message: failure.message)),
          (data) => emit(AuthenticationLogoutLoaded(data: data)));
    });

  }
}
