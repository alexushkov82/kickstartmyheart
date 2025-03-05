import 'package:flutter/material.dart';
import 'package:kickstartmyheart/core/extensions/buildcontext/loc.dart';
import 'generic_dialog.dart';

Future<void> showPasswordResetEmailSentDialog (BuildContext context) {
  return showGenericDialog(
    context: context,
    title: context.loc.password_reset,
    content: context.loc.password_reset_dialog_prompt,
    optionsBuilder: () =>  {
      context.loc.ok: null,
    },
  );
}