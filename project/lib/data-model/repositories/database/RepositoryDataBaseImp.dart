// lib/features/todo_list/data/repositories/task_repository_impl.dart
import 'package:project/data-model/entities/DiaModel.dart';

import '../../../domain-viewModel/entities/Task.dart';
import '../../../domain-viewModel/repositories-interfaces/RepositoryDataBase.dart';
import '../../datasources/local_database.dart';

class TaskRepositoryImpl implements ITaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTask(Dia dia) async {
    
    await localDataSource.salvarDia(dia as DiaModel, dia.date);
  }

  @override
  Future<List<Dia>> getDays() async {
    // 1. Busca a lista de Maps do SQLite através do Data Source
    final List<Map<String, dynamic>> maps = await localDataSource.getDays();

    // 2. Converte cada Map em um TaskModel (que é uma TaskEntity)
    return maps.map((map) => DiaModel.fromMap(map)).toList();
  }
  
}
