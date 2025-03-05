import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String ownerUserId;
  final String title;
  final String description;
  final DateTime dueDate;

  const Task({
    required this.id,
    required this.ownerUserId,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  Task.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        ownerUserId = snapshot.data()['user_id'],
        title = snapshot.data()['title'] as String,
        description = snapshot.data()['description'] as String,
        dueDate = (snapshot.data()['date'] as Timestamp).toDate();
}