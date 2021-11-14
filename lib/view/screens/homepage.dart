import 'package:flutter/material.dart';
import 'package:flutter_project/view/widgets/taskcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal[300]),
              child: const Text('Way to Stars'),
            )
          ],
        ),
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
                icon: Icon(Icons.menu)),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          TextField(
                            decoration: InputDecoration(hintText: 'Task title'),
                            autofocus: true,
                          ),
                          TextField(
                            decoration:
                                InputDecoration(hintText: 'Task description'),
                            autofocus: true,
                          ),
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
        child: ListView(
          children: const [
            TaskCard(),
            TaskCard(),
            TaskCard(),
            TaskCard(),
            TaskCard(),
            TaskCard(),
            TaskCard(),
            TaskCard(),
            TaskCard(),
            TaskCard(),
            TaskCard(),
          ],
        ),
      ),
    );
  }
}
