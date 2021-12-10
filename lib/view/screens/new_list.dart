import 'package:flutter/material.dart';
import 'package:flutter_project/api/database_helper.dart';
import 'package:flutter_project/models/list.dart';

class NewList extends StatefulWidget {
  const NewList({Key? key}) : super(key: key);

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  final newListController = TextEditingController();

  @override
  void dispose() {
    newListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new list'),
        actions: [
          TextButton(
            onPressed: () async {
              if (newListController.text != "") {
                DatabaseHelper _dbHelper = DatabaseHelper();
                ToDoList _newList = ToDoList(
                  title: newListController.text,
                );
                await _dbHelper
                    .insertList(_newList)
                    .then((_newList) => Navigator.pop(context));
              }
            },
            child: const Text(
              'Done',
              style: TextStyle(fontSize: 18),
            ),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      body: TextField(
        controller: newListController,
        autofocus: true,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Enter list name'),
      ),
    );
  }
}
