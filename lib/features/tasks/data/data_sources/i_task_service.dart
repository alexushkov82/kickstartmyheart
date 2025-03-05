import 'package:kickstartmyheart/features/tasks/domain/entities/task.dart';

abstract class ITaskService {
  Future<Task> createNewTask({
    required String userId,
  });

  Stream<Iterable<Task>> allTasks({
    required String userId,
  });

  Future<void> updateTask({
    required String taskId,
    String? title,
    String? description,
    DateTime? dueDate,
  });

  Future<void> deleteTask({
    required String taskId,
  });
}
