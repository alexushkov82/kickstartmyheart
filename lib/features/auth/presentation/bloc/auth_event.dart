part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthInitialize extends AuthEvent {
  const AuthInitialize();
}

class AuthShouldRegister extends AuthEvent {
  const AuthShouldRegister();
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;

  const AuthRegister(
    this.email,
    this.password,
  );
}

class AuthSendEmailVerification extends AuthEvent {
  const AuthSendEmailVerification();
}

class AuthLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthLogIn(
    this.email,
    this.password,
  );
}

class AuthForgotPassword extends AuthEvent {
  final String? email;

  const AuthForgotPassword({this.email});
}

class AuthLogOut extends AuthEvent {
  const AuthLogOut();
}
