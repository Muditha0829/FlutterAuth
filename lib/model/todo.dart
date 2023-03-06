import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    this.id,
    this.todoText,
    required this.isDone,
  });

  factory ToDo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ToDo(
      id: data?['id'],
      todoText: data?['todoText'],
      isDone: data?['isDone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (todoText != null) "todoText": todoText,
      if (isDone != null) "isDone": isDone,
    };
  }
}
