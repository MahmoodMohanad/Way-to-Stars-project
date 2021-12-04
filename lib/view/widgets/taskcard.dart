import 'package:flutter/material.dart';

import 'package:flutter_project/view/screens/taskpage.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.title,
    this.description = '',
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const Text(
              'date',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
