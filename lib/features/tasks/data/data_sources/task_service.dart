import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickstartmyheart/features/tasks/data/data_sources/i_task_service.dart';
import 'package:kickstartmyheart/features/tasks/domain/entities/task.dart';

import 'task_exceptions.dart';

class TaskService implements ITaskService {
  final tasks = FirebaseFirestore.instance.collection('tasks');

  static final TaskService _shared = TaskService._sharedInstance();

  TaskService._sharedInstance();

  factory TaskService() => _shared;

  @override
  Future<Task> createNewTask({required String userId}) async {
    final document = await tasks.add({
      'user_id': userId,
      'title': '',
      'description': '',
      'date': DateTime.now(),
    });
    final fetchedTask = await document.get();
    return Task(
      id: fetchedTask.id,
      ownerUserId: userId,
      title: '',
      description: '',
      dueDate: DateTime.now(),
    );
  }

  @override
  Stream<Iterable<Task>> allTasks({required String userId}) {
    final allTasks = tasks.where('user_id', isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs
        .map((doc) => Task.fromSnapshot(doc)));
    return allTasks;
  }

  @override
  Future<void> updateTask({
    required String taskId,
    String? title,
    String? description,
    DateTime? dueDate,
  }) async {
    if (title == null && description == null && dueDate == null) {
      throw CouldNotUpdateTaskException();
    }
    try {
      await tasks.doc(taskId).update({
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (dueDate != null) 'date': DateTime.now(),
      });
    } catch (e) {
      throw CouldNotUpdateTaskException();
    }
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    try {
      await tasks.doc(taskId).delete();
    } catch (e) {
      throw CouldNotDeleteTaskException();
    }
  }
}
