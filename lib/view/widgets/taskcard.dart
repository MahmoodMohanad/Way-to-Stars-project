import 'package:flutter/material.dart';
import 'package:flutter_project/api/database_helper.dart';

import 'package:flutter_project/models/task.dart';
import 'package:flutter_project/view/screens/taskpage.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key? key, required this.task, required this.notifyParent})
      : super(key: key);

  final Function() notifyParent;
  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.task.isDone == 0 ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskPage(
                    task: widget.task,
                  )),
        )
            .then((value) => setState(() {}))
            .then((value) => widget.notifyParent());
      },
      child: Card(
        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  widget.task.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Spacer(),
            Checkbox(
                shape: const CircleBorder(side: BorderSide()),
                value: isChecked,
                onChanged: (value) async {
                  Task _updatedTask = widget.task;
                  if (_updatedTask.isDone == 0) {
                    _updatedTask.isDone = 1;
                  } else if (_updatedTask.isDone == 1) {
                    _updatedTask.isDone = 0;
                  }
                  await _dbHelper.updateTask(_updatedTask);
                  setState(() {
                    value = isChecked;
                  });
                  Future.delayed(
                      const Duration(milliseconds: 30), widget.notifyParent);
                })
          ]),
        ),
      ),
    );
  }
}
