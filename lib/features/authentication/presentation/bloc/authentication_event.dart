part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignUpAuthEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final File file;

  const SignUpAuthEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.file,

  });

  @override
  List<Object> get props => [
        email, password, name, phone,
      ];
}

class SignInAuthEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInAuthEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthCheckCredential extends AuthenticationEvent {}

class AuthLogoutEvent extends AuthenticationEvent {}
