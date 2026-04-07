// lib/features/task/data/models/task_model.dart
import '../../domain-viewModel/entities/Task.dart';

class TaskModel extends Task {
  TaskModel({super.id, required super.date, required super.value});

  // Transforma o Map do SQLite em um Model/Entity
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      date: DateTime.parse(map['date']),
      value: map['value'],
    );
  }
 
  // Transforma o Model em um Map para salvar no SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'value': value,
    };
  }
}