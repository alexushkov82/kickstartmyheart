import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:kickstartmyheart/services/auth/auth_user.dart';


@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;

  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required super.isLoading});
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;

  const AuthStateRegistering({required this.exception, required super.isLoading});
}

class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification({required super.isLoading});
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;

  const AuthStateLoggedIn({required this.user, required super.isLoading});
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;

  const AuthStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required super.isLoading,
  });
}

class AuthStateLoggedOut extends AuthState with EquatableMixin{
  final Exception? exception;

  const AuthStateLoggedOut({
    required this.exception,
    required super.isLoading,
    super.loadingText = null,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}