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
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  var currentListId = 1;
  var currentList = DatabaseHelper().getList(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal[300]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Way to Stars',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewList()))
                            .then((value) => setState(() {}));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.add),
                          Text(
                            'New list',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  initialData: const [],
                  future: _dbHelper.getLists(),
                  builder: (context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              currentListId = snapshot.data[index].id;
                              currentList =
                                  DatabaseHelper().getList(currentListId);
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: ListTile(
                              title: Text(
                                snapshot.data[index].title,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      )),
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
            IconButton(
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
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('Delete List'),
                                onTap: () {
                                  if (currentListId == 1) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: const Text('Note'),
                                              content: const Text(
                                                  'You can\'t remove the default to do list'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Close'),
                                                  child: const Text('Close'),
                                                ),
                                              ]);
                                        });
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Alert'),
                                        content: const Text(
                                            'Are you sure you want to delete this list?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _dbHelper
                                                  .deleteList(currentListId)
                                                  .then((value) =>
                                                      Navigator.pop(context))
                                                  .then((value) =>
                                                      Navigator.pop(context))
                                                  .then(
                                                    (value) => setState(() {
                                                      currentListId = 1;
                                                      currentList =
                                                          DatabaseHelper()
                                                              .getList(
                                                                  currentListId);
                                                    }),
                                                  );
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              ListTile(
                                title: Text('Delete all completed tasks'),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.more_vert),
            )
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: taskTitleController,
                            decoration: InputDecoration(
                                hintText: 'New Task',
                                filled: true,
                                fillColor: Colors.grey[200]),
                            autofocus: true,
                          ),
                          TextField(
                            controller: taskDescriptionController,
                            decoration: InputDecoration(
                                hintText: 'Task description',
                                filled: true,
                                fillColor: Colors.grey[200]),
                            autofocus: true,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: ElevatedButton(
                                onPressed: () async {
                                  DatabaseHelper _dbHelper = DatabaseHelper();
                                  Task _newTask = Task(
                                      title: taskTitleController.text,
                                      listId: currentListId,
                                      description:
                                          taskDescriptionController.text);
                                  await _dbHelper
                                      .insertTask(_newTask)
                                      .then((value) => Navigator.pop(context))
                                      .then((value) => setState(() {}));
                                },
                                child: const Text('Add')),
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
          height: double.infinity,
          color: Colors.teal[50],
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: FutureBuilder(
                    future: currentList,
                    builder: (context, AsyncSnapshot snapshot) {
                      var title = snapshot.data.toString();
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5, left: 20, right: 20),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                      );
                    }),
              ),
              FutureBuilder(
                initialData: const [],
                future: _dbHelper.getListTasks(currentListId),
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TaskPage(task: snapshot.data![index])),
                            ).then((value) => setState(() {}));
                          },
                          child: TaskCard(
                            title: snapshot.data[index].title,
                            description: snapshot.data[index].description,
                          ),
                        );
                      });
                },
              ),
            ],
          )),
    );
  }
}
