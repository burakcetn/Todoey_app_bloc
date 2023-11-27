import 'package:sqflite/sql.dart';
import 'package:todo_bootcamp/data/locals/database_helper.dart';
import 'package:todo_bootcamp/data/models/task_model.dart';

class TaskRepository {
  Future<List<TaskModel>> getTasks() async {
    var db = await DatabaseHelper.instance();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    for (var element in maps) {
      var kisi = TaskModel.fromJson(element);
      print(kisi.id);
      print(kisi.title);
    }
    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
      );
    });
  }

  Future<void> insertTask(String title) async {
    var db = await DatabaseHelper.instance();
    var task = Map<String, dynamic>();
    task["title"] = title;
    await db.insert(
      "tasks",
      task,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(String title, int id) async {
    var db = await DatabaseHelper.instance();
    var task = Map<String, dynamic>();
    task["title"] = title;
    await db.update("tasks", task, where: "id = ?", whereArgs: [id]);
  }

  Future<List<TaskModel>> searchTask(String query) async {
    var db = await DatabaseHelper.instance();
    List<Map<String, dynamic>> rows =
        await db.rawQuery("SELECT * FROM tasks WHERE title like '%$query%'");
    return List.generate(rows.length, (i) {
      return TaskModel(
        id: rows[i]['id'] as int,
        title: rows[i]['title'] as String,
      );
    });
  }

  Future<void> deleteTask(int id) async {
    var db = await DatabaseHelper.instance();
    await db.delete(
      "tasks",
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
