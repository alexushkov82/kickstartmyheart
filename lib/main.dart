import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kickstartmyheart/constants/routes.dart';
import 'package:kickstartmyheart/services/auth/bloc/auth_bloc.dart';
import 'package:kickstartmyheart/services/auth/bloc/auth_event.dart';
import 'package:kickstartmyheart/services/auth/bloc/auth_state.dart';
import 'package:kickstartmyheart/services/auth/firebase_auth_provider.dart';
import 'package:kickstartmyheart/views/auth/forgot_password_view.dart';
import 'package:kickstartmyheart/views/auth/login_view.dart';
import 'package:kickstartmyheart/views/notes/create_update_note_view.dart';
import 'package:kickstartmyheart/views/notes/notes_view.dart';
import 'package:kickstartmyheart/views/auth/register_view.dart';
import 'package:kickstartmyheart/views/auth/verify_email_view.dart';
import 'package:kickstartmyheart/helpers/loading/loading_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      title: 'kickstartmyheart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}