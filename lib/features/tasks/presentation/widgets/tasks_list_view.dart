import 'package:flutter/material.dart';

import '../../../../core/utilities/dialogs/delete_dialog.dart';
import '../../domain/entities/task.dart';

typedef TaskCallback = void Function(Task task);

class TasksListView extends StatelessWidget {
  final Iterable<Task> tasks;
  final TaskCallback onDeleteTask;
  final TaskCallback onTap;

  const TasksListView({
    super.key,
    required this.tasks,
    required this.onDeleteTask,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(task);
          },
          title: Text(
            task.title,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteTask(task);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}