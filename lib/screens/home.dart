import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/screens/profile.dart';
import 'package:mytodo/services/auth.dart';
import 'package:mytodo/widgets/todo_item.dart';
import '../model/todo.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//Declaring variables
  // final List<ToDo> todosList = ToDo(isDone: false) as List<ToDo>;
  final _todoController = TextEditingController();
  var uuid = const Uuid();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  final Stream<QuerySnapshot> _todoStream =
      FirebaseFirestore.instance.collection('tasks').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const Profile()));
                  },
          )
        ],
        title: const Text('To-Do List IT20233358'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _todoStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return ToDoItem(
                    todo: data['todoText'],
                    isDone: data['isDone'],
                    id: data['id'],
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _deleteToDoItem,
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
      //Button to display the dialog to add items
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

//Method to change the completion status of tasks
  void _handleToDoChange(id,isDone) {
    

    final changeRef = _fireStore.collection("tasks").doc(id);

    changeRef.update({"isDone": !isDone}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

//Method to remove items from the tasks
  void _deleteToDoItem(String id) {
    _fireStore.collection("tasks").doc(id).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

//Method to add item to the todo list
  taskSubmission(String toDo) async {
    try {
      String todoId = uuid.v4();
      ToDo todo = ToDo(isDone: false);

      _fireStore
          .collection("tasks")
          .doc(todoId)
          .set({"id": todoId, "todoText": toDo, "isDone": false});
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Submit Failed",
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      );
    }
    _todoController.clear();
  }

  // display a dialog for the user to enter items
  Future<Future> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _todoController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              // add button
              ElevatedButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  taskSubmission(_todoController.text);
                },
              ),
              // Cancel button
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
