import 'dart:developer' as Developer show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/domain-viewModel/entities/Task.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryDataBase.dart';
import 'package:project/domain-viewModel/use_cases/OCR/beginOCR.dart';

class Buttonstate extends ChangeNotifier {
  final BeginOCR beginOCRUseCase;
  final ITaskRepository database;

  bool _loading = false;

  bool get loading => _loading;

  Buttonstate({required this.beginOCRUseCase, required this.database});
  Future<void> beginOCR() async {
    Developer.log('Iniciando OCR');
    _loading = true;
    notifyListeners();
    Developer.log('Loading set to true');

    final result = await beginOCRUseCase.call(source: ImageSource.gallery);
    result.fold(
      (failure) {
        Developer.log(
          'Falha no processo de OCR',
          name: 'OCR',
          error: failure.message,
        );
      },
      (value) async {
        database.addTask(Task(date: DateTime.now(), value: value));
        Developer.log(name: "OCR", 'Valor encontrado: $value');

        try {
          // Chama o repositório
          final tasks = await database.getAllTasks();

          if (tasks.isEmpty) {
            print("--- Nenhuma tarefa encontrada no SQLite ---");
            return;
          }

          print("--- LISTANDO TAREFAS DO BANCO ---");
          for (var task in tasks) {
            print(
              "ID: ${task.id} | Título: ${task.date} | Valor: R\$ ${task.value}",
            );
          }
          print("---------------------------------");
        } catch (e) {
          print("Erro ao listar tarefas: $e");
        }
      },
    );

    _loading = false;
    notifyListeners();
  }
}
