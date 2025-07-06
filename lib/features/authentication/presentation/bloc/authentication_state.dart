part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();  

  @override
  List<Object> get props => [];
}
class AuthenticationInitial extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}
class AuthenticationFailed extends AuthenticationState {
  final String message;

  const AuthenticationFailed({required this.message});
}
class AuthenticationSignUpLoaded extends AuthenticationState {
  final AuthEntity data;

  const AuthenticationSignUpLoaded({required this.data});

   @override
   List<Object> get props => [data];

}

class AuthenticationSignInLoaded extends AuthenticationState {
  final String data;

  const AuthenticationSignInLoaded({required this.data});

   @override
   List<Object> get props => [data];

}

class AuthenticationCheckCredentialLoaded extends AuthenticationState {}

class AuthenticationLogoutLoaded extends AuthenticationState {
  final Unit data;

  AuthenticationLogoutLoaded({required this.data});
}