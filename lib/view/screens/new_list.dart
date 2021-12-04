import 'package:flutter/material.dart';
import 'package:flutter_project/api/database_helper.dart';
import 'package:flutter_project/models/list.dart';

import 'homepage.dart';

class NewList extends StatelessWidget {
  NewList({Key? key}) : super(key: key);

  final HomePageKey = GlobalKey<HomePageState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new list'),
        actions: [TextButton(onPressed: () {}, child: const Text('Done'))],
      ),
      body: Container(
        child: TextField(
          onSubmitted: (value) async {
            if (value != "") {
              DatabaseHelper _dbHelper = DatabaseHelper();
              ToDoList _newList = ToDoList(
                title: value,
              );
              await _dbHelper
                  .insertList(_newList)
                  .then((value) => Navigator.pop(context));
            }
          },
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter list name'),
        ),
      ),
    );
  }
}
