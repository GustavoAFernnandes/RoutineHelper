// lib/features/todo_list/data/repositories/task_repository_impl.dart
import 'package:project/data-model/entities/TaskImp.dart';

import '../../../domain-viewModel/entities/Task.dart';
import '../../../domain-viewModel/repositories-interfaces/RepositoryDataBase.dart';
import '../../datasources/local_database.dart';

class TaskRepositoryImpl implements ITaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTask(Task task) async {
    // Converte a entidade de domínio para um mapa que o banco entende
    final map = {'date': task.date.toIso8601String(), 'value': task.value};
    await localDataSource.insert(map);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    // 1. Busca a lista de Maps do SQLite através do Data Source
    final List<Map<String, dynamic>> maps = await localDataSource.getTasks();

    // 2. Converte cada Map em um TaskModel (que é uma TaskEntity)
    return maps.map((map) => TaskModel.fromMap(map)).toList();
  }
}
