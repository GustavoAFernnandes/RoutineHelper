// lib/features/todo_list/domain/repositories/task_repository.dart
import '../entities/Task.dart';

abstract class ITaskRepository {
  Future<void> addTask(Task task);
  Future<List<Task>> getAllTasks();
}