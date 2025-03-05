import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kickstartmyheart/core/extensions/buildcontext/loc.dart';

import '../../../../core/utilities/dialogs/error_dialog.dart';
import '../../../../core/utilities/dialogs/password_reset_email_sent_dialog.dart';
import '../bloc/auth_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            showPasswordResetEmailSentDialog(context);
          }
          if (state.exception != null) {
            showErrorDialog(
              context,
              context.loc.forgot_password_view_generic_error,
            );
          }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(context.loc.forgot_password),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(context.loc.forgot_password_view_prompt),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autofocus: true,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: context.loc.email_text_field_placeholder,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final email = _controller.text;
                      AuthBloc.of(context).add(AuthForgotPassword(email: email));
                    },
                    child: Text(context.loc.forgot_password_view_send_me_link),
                  ),
                  TextButton(
                    onPressed: () {
                      AuthBloc.of(context).add(const AuthLogOut());
                    },
                    child: Text(context.loc.forgot_password_view_back_to_login),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
