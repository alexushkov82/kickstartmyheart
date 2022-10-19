import 'package:kickstartmyheart/services/auth/auth_user.dart';

abstract class AuthProvider {

  Future<void> initialize();

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  AuthUser? get currentUser;

  Future<void> sendEmailVerification();

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<void> sendPasswordReset({required String toEmail});

  Future<void> logOut();
}
