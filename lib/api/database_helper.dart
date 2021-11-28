import 'package:flutter_project/models/list.dart';
import 'package:flutter_project/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'wts_db.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, listid INTEGER, title TEXT, description TEXT, isDone INTEGER)");
        await db
            .execute("CREATE TABLE lists(id INTEGER PRIMARY KEY, title TEXT)");
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    Database _db = await database();
    await _db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertList(ToDoList list) async {
    Database _db = await database();
    await _db.insert('lists', list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (i) {
      return Task(
          id: taskMap[i]['id'],
          title: taskMap[i]['title'],
          description: taskMap[i]['description']);
    });
  }

  Future<List<ToDoList>> getLists() async {
    Database _db = await database();
    List<Map<String, dynamic>> listMap = await _db.query('lists');
    return List.generate(listMap.length, (i) {
      return ToDoList(id: listMap[i]['id'], title: listMap[i]['title']);
    });
  }
}
