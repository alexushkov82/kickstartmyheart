import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/i_auth_serivce.dart';
import '../../domain/entities/auth_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;

  AuthBloc({
    required IAuthService authService,
  })  : _authService = authService,
        super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthInitialize>(_onAutInitialize);
    on<AuthShouldRegister>(_onAuthShouldRegister);
    on<AuthRegister>(_onAuthRegister);
    on<AuthSendEmailVerification>(_onAuthSendEmailVerification);
    on<AuthLogIn>(_onAuthLogIn);
    on<AuthForgotPassword>(_onAuthForgotPassword);
    on<AuthLogOut>(_onAuthLogOut);
  }

  factory AuthBloc.of(BuildContext context) {
    return BlocProvider.of<AuthBloc>(context);
  }

  void _onAutInitialize(
    AuthInitialize event,
    Emitter<AuthState> emit,
  ) async {
    await _authService.initialize();
    final user = _authService.currentUser;
    if (user == null) {
      emit(const AuthStateLoggedOut(
        exception: null,
        isLoading: false,
      ));
    } else if (!user.isEmailVerified) {
      emit(const AuthStateNeedVerification(isLoading: false));
    } else {
      emit(AuthStateLoggedIn(user: user, isLoading: false));
    }
  }

  void _onAuthShouldRegister(
    AuthShouldRegister event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthStateRegistering(exception: null, isLoading: false));
  }

  void _onAuthRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    final email = event.email;
    final password = event.password;
    try {
      await _authService.createUser(email: email, password: password);
      await _authService.sendEmailVerification();
      emit(const AuthStateNeedVerification(isLoading: false));
    } on Exception catch (e) {
      emit(AuthStateRegistering(exception: e, isLoading: false));
    }
  }

  void _onAuthSendEmailVerification(
    AuthSendEmailVerification event,
    Emitter<AuthState> emit,
  ) async {
    await _authService.sendEmailVerification();
    emit(state);
  }

  void _onAuthLogIn(
    AuthLogIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoggedOut(
      exception: null,
      isLoading: true,
      loadingText: 'Please wait while You are logging in',
    ));
    final email = event.email;
    final password = event.password;
    try {
      final user = await _authService.logIn(email: email, password: password);
      if (!user.isEmailVerified) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        emit(const AuthStateNeedVerification(isLoading: false));
      } else {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      }
    }  on Exception catch (e) {
      emit(AuthStateLoggedOut(exception: e, isLoading: false));
    }
  }

  void _onAuthForgotPassword(
    AuthForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateForgotPassword(
      exception: null,
      hasSentEmail: false,
      isLoading: false,
    ));
    final email = event.email;
    if (email == null) {
      return;
    }

    emit(const AuthStateForgotPassword(
      exception: null,
      hasSentEmail: false,
      isLoading: true,
    ));

    bool didSendEmail;
    Exception? exception;
    try {
      await _authService.sendPasswordReset(toEmail: email);
      didSendEmail = true;
      exception = null;
    } on Exception catch (e) {
      didSendEmail = false;
      exception = e;
    }

    emit(AuthStateForgotPassword(
      exception: exception,
      hasSentEmail: didSendEmail,
      isLoading: false,
    ));
  }

  void _onAuthLogOut(
    AuthLogOut event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.logOut();
      emit(const AuthStateLoggedOut(exception: null, isLoading: false));
    } on Exception catch (e) {
      emit(AuthStateLoggedOut(exception: e, isLoading: false));
    }
  }
}
