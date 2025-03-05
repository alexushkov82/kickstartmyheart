import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kickstartmyheart/core/extensions/buildcontext/loc.dart';
import 'package:kickstartmyheart/features/tasks/data/data_sources/i_task_service.dart';
import 'package:kickstartmyheart/features/tasks/data/data_sources/task_service.dart';
import 'package:kickstartmyheart/features/tasks/presentation/pages/task_page.dart';
import 'package:kickstartmyheart/features/tasks/presentation/widgets/tasks_list_view.dart';

import '../../../../config/enums/menu_action.dart';
import '../../../../core/utilities/dialogs/logout_dialog.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/task.dart';

extension Count<T extends Iterable> on Stream<T> {
  Stream<int> get getLength => map((event) => event.length);
}

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late final ITaskService _taskService;

  String get userId =>
      (AuthBloc.of(context).state as AuthStateLoggedIn).user.id;

  @override
  void initState() {
    _taskService = TaskService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _taskService.allTasks(userId: userId).getLength,
          builder: (context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData) {
              final tasksCount = snapshot.data ?? 0;
              final text = context.loc.tasks_title(tasksCount);
              return Text(text);
            } else {
              return const Text('');
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (buildContext) {
                  return BlocProvider.value(
                    value: AuthBloc.of(context),
                    child: const TaskPage(),
                  );
                }),
              );
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    AuthBloc.of(context).add(const AuthLogOut());
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text(context.loc.logout_button),
                ),
              ];
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _taskService.allTasks(userId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allTasks = snapshot.data as Iterable<Task>;
                return TasksListView(
                  tasks: allTasks,
                  onDeleteTask: (task) async {
                    await _taskService.deleteTask(taskId: task.id);
                  },
                  onTap: (task) async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (buildContext) {
                        return BlocProvider.value(
                          value: AuthBloc.of(context),
                          child: TaskPage(
                            task: task,
                          ),
                        );
                      }),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
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
