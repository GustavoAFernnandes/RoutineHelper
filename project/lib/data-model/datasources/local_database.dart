// lib/features/todo_list/data/datasources/task_local_datasource.dart
import '../../core/database_helper.dart';

class TaskLocalDataSource {
  final DatabaseHelper dbHelper;
  TaskLocalDataSource(this.dbHelper);

  Future<void> insert(Map<String, dynamic> taskMap) async {
    final db = await dbHelper.database;
    await db.insert('tasks', taskMap);
  }
  Future<List<Map<String, dynamic>>> getTasks() async {
  final db = await dbHelper.database;
  return await db.query('tasks'); // SELECT * FROM tasks
}
}