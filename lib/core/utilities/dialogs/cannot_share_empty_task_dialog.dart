import 'package:flutter/material.dart';
import 'package:kickstartmyheart/core/extensions/buildcontext/loc.dart';
import 'generic_dialog.dart';

Future<void> showCannotShareEmptyTaskDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: context.loc.sharing,
    content: context.loc.cannot_share_empty_task_prompt,
    optionsBuilder: () => {
      context.loc.ok: null,
    },
  );
}