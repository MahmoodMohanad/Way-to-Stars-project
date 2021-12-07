import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_project/api/database_helper.dart';
import 'package:flutter_project/models/task.dart';
import 'package:path/path.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String _taskTitle = "";
  String _taskDescription = "";
  var currentList;
  var taskTitleController = TextEditingController();
  var taskDescriptionController = TextEditingController();

  @override
  void initState() {
    _taskTitle = widget.task.title;
    _taskDescription = widget.task.description;
    currentList = DatabaseHelper().getList(widget.task.listId);
    taskTitleController = TextEditingController(text: _taskTitle);
    taskDescriptionController = TextEditingController(text: _taskDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Alert'),
                    content: const Text(
                        'Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _dbHelper
                              .deleteTask(widget.task.id)
                              .then((value) => Navigator.pop(context, 'Delete'))
                              .then((value) => Navigator.pop(context));
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: currentList,
                builder: (context, AsyncSnapshot snapshot) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  );
                }),
            TextField(
              controller: taskTitleController,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            const Text('Description'),
            Expanded(
              child: TextField(
                maxLines: 6,
                controller: taskDescriptionController,
                style: const TextStyle(fontSize: 20, color: Colors.black87),
                decoration:
                    InputDecoration(filled: true, fillColor: Colors.grey[200]),
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          DatabaseHelper _dbHelper = DatabaseHelper();
                          Task _updatedTask = Task(
                              id: widget.task.id,
                              title: taskTitleController.text,
                              listId: widget.task.listId,
                              description: taskDescriptionController.text,
                              isDone: widget.task.isDone);
                          await _dbHelper
                              .updateTask(_updatedTask)
                              .then((value) => Navigator.pop(context));
                        },
                        child: const Text('Save')),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Mark Completed')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
