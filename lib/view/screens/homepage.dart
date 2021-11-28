import 'package:flutter/material.dart';
import 'package:flutter_project/api/database_helper.dart';
import 'package:flutter_project/models/list.dart';
import 'package:flutter_project/models/task.dart';
import 'package:flutter_project/view/screens/new_list.dart';
import 'package:flutter_project/view/screens/taskpage.dart';
import 'package:flutter_project/view/widgets/taskcard.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    asyncMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: FutureBuilder(
            initialData: const [],
            future: _dbHelper.getLists(),
            builder: (context, AsyncSnapshot snapshot) {
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.teal[300]),
                    child: const Text(
                      'Way to Stars',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewList()));
                      },
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.add),
                            Text(
                              'New list',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            snapshot.data[index].title,
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      })
                ],
              );
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu)),
            const Spacer(),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(5))),
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            onSubmitted: (value) async {
                              if (value != "") {
                                DatabaseHelper _dbHelper = DatabaseHelper();
                                Task _newTask = Task(title: value);
                                await _dbHelper
                                    .insertTask(_newTask)
                                    .then((value) => Navigator.pop(context))
                                    .then((value) => setState(() {}));
                              }
                            },
                            decoration: const InputDecoration(
                                hintText: 'New Task', border: InputBorder.none),
                            autofocus: true,
                          ),
                          const TextField(
                            decoration: InputDecoration(
                                hintText: 'Task description',
                                border: InputBorder.none),
                            autofocus: true,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: ElevatedButton(
                                onPressed: () {}, child: const Text('Add')),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Way to Stars'),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.teal[50],
          child: FutureBuilder(
            initialData: const [],
            future: _dbHelper.getTasks(),
            builder: (context, AsyncSnapshot snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TaskPage(task: snapshot.data[index])),
                        );
                      },
                      child: TaskCard(
                        title: snapshot.data[index].title,
                      ),
                    );
                  });
            },
          )),
    );
  }
}

asyncMethod() async {
  DatabaseHelper _dbHelper = DatabaseHelper();
  ToDoList _newList = ToDoList(title: 'My Tasks');
  var list = await _dbHelper.getLists();
  if (list.isEmpty) {
    await _dbHelper.insertList(_newList);
  }
}
