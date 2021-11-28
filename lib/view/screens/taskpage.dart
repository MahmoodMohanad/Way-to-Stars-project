import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _taskTitle = "";

  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task.title;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List name',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            TextField(
              controller: TextEditingController(text: _taskTitle),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                constraints: BoxConstraints.tightForFinite(),
                border: InputBorder.none,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.description,
                  size: 20,
                ),
                Flexible(
                  child: TextField(
                    controller: TextEditingController(text: 'description'),
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.date_range_rounded,
                  size: 20,
                ),
                Flexible(
                  child: TextField(
                    controller: TextEditingController(text: 'Date'),
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text('Save')),
                    Spacer(),
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
