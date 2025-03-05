import 'package:flutter/material.dart';
import 'package:kickstartmyheart/core/extensions/buildcontext/loc.dart';
import 'package:kickstartmyheart/features/tasks/data/data_sources/i_task_service.dart';
import 'package:kickstartmyheart/features/tasks/data/data_sources/task_service.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utilities/dialogs/cannot_share_empty_task_dialog.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/task.dart';

class TaskPage extends StatefulWidget {
  final Task? task;

  const TaskPage({super.key, this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Task? _task;
  late final ITaskService _taskService;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  AuthStateLoggedIn get authState => AuthBloc.of(context).state as AuthStateLoggedIn;

  @override
  void initState() {
    super.initState();
    _taskService = TaskService();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void _taskControllerListener() async {
    final task = _task;
    if (task == null) {
      return;
    }
    final title = _titleController.text;
    final description = _descriptionController.text;
    await _taskService.updateTask(
      taskId: task.id,
      title: title,
      description: description,
    );
  }

  Future<Task> createOrGetExistingTask(BuildContext context) async {
    final existingTask = widget.task;

    if (existingTask != null) {
      _task = existingTask;
      _titleController.text = existingTask.title;
      _descriptionController.text = existingTask.description;
      return existingTask;
    }

    final newTask = _task;
    if (newTask != null) {
      return newTask;
    }
    final userId = authState.user.id;
    final task =  await _taskService.createNewTask(userId: userId);
    _task = task;
    return task;
  }

  void _setupTextControllerListener() {
    _titleController.removeListener(_taskControllerListener);
    _descriptionController.removeListener(_taskControllerListener);
    _titleController.addListener(_taskControllerListener);
    _descriptionController.addListener(_taskControllerListener);
  }

  void _deleteTaskIfIsEmpty() {
    final task = _task;
    if (task != null && _titleController.text.isEmpty) {
      _taskService.deleteTask(taskId: task.id);
    }
  }

  void _saveTaskIfNotEmpty() async {
    final task = _task;
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (task != null && title.isNotEmpty) {
      await _taskService.updateTask(
        taskId: task.id,
        title: title,
        description: description,
        dueDate: DateTime.now(),
      );
    }
  }

  @override
  void dispose() {
    _deleteTaskIfIsEmpty();
    _saveTaskIfNotEmpty();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.task),
        actions: [
          IconButton(
            onPressed: () async {
              final title = _titleController.text;
              final description = _titleController.text;
              if (_task == null || title.isEmpty) {
                await showCannotShareEmptyTaskDialog(context);
              } else {
                Share.share('Task Title: $title\nDescription: $description');
              }
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: FutureBuilder(
        future: createOrGetExistingTask(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: context.loc.type_your_task_title,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: context.loc.type_your_task_description,
                      ),
                    ),
                  ],
                ),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
