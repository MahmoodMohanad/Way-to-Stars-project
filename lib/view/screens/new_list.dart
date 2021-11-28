import 'package:flutter/material.dart';

class NewList extends StatelessWidget {
  const NewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new list'),
        actions: [TextButton(onPressed: () {}, child: Text('Done'))],
      ),
      body: Container(
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter list name'),
        ),
      ),
    );
  }
}
