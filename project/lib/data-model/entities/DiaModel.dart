// lib/features/task/data/models/task_model.dart
import '../../domain-viewModel/entities/Task.dart';

class DiaModel extends Dia {
  DiaModel({ super.id, required super.date, required super.value, required super.mes_id});

  // Transforma o Map do SQLite em um Model/Entity
  factory DiaModel.fromMap(Map<String, dynamic> map) {
    return DiaModel(
      id: map['id'],
      date: DateTime.parse(map['date']),
      value: map['value'],
      mes_id: map['mes_id'],
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