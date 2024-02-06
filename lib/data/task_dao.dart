import 'package:first_app/components/task.dart';
import 'package:first_app/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String _tableName = 'task';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  save(Task task) async {
    final Database database = await getDatabase();
    var itemExists = await findByName(task.description);
    if (itemExists.isEmpty) {
      return await database.insert(_tableName, toMap(task));
    } else {
      return await database.update(_tableName, toMap(task),
          where: '$_name = ?', whereArgs: [task.description]);
    }
  }

  delete(Task task) async {
    final Database database = await getDatabase();
    return await database
        .delete(_tableName, where: '$_name = ?', whereArgs: [task.description]);
  }

  Future<List<Task>> findAll() async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tableName);

    return toList(result);
  }

  Future<List<Task>> findByName(String taskName) async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database
        .query(_tableName, where: '$_name = ?', whereArgs: [taskName]);

    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> taskList) {
    final List<Task> tasks = [];

    for (Map<String, dynamic> row in taskList) {
      final Task task = Task(
          description: row[_name],
          urlImage: row[_image],
          difficulty: row[_difficulty]);
      tasks.add(task);
    }

    return tasks;
  }

  Map<String, dynamic> toMap(Task task) {
    final Map<String, dynamic> map = {};
    map[_name] = task.description;
    map[_difficulty] = task.difficulty;
    map[_image] = task.urlImage;

    return map;
  }
}
