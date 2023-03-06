import 'package:flutter/material.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final todo;
  final isDone;
  final id;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.isDone,
    required this.id,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          onToDoChanged(id,isDone);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blueAccent,
        ),
        title: Text(
          todo,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            //Indicate when the task is already done
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
            iconSize: 25,
            color: Colors.red,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(id);
            },
          ),
      ),
    );
  }
}