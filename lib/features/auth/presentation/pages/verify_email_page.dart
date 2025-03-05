import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kickstartmyheart/core/extensions/buildcontext/loc.dart';

import '../bloc/auth_bloc.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.verify_email),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(context.loc.verify_email_view_prompt),
              TextButton(
                onPressed: () {
                  AuthBloc.of(context).add(const AuthSendEmailVerification());
                },
                child: Text(context.loc.verify_email_send_email_verification),
              ),
              TextButton(
                onPressed: () async {
                  AuthBloc.of(context).add(const AuthLogOut());
                },
                child: Text(context.loc.restart),
              )
            ],
          ),
        ),
      ),
    );
  }
}
