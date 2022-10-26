import 'package:flutter/material.dart';
import 'package:kickstartmyheart/extensions/buildcontext/loc.dart';
import 'package:kickstartmyheart/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.generic_error_prompt,
    content: text,
    optionsBuilder: () => {
      context.loc.ok: null,
    },
  );
}
