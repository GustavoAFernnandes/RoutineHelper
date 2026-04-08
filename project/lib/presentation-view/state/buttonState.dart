import 'dart:developer' as Developer show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/data-model/entities/DiaModel.dart';
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
        database.addTask(DiaModel(date: DateTime.now(), value: double.parse(value), mes_id: null));
        Developer.log(name: "OCR", 'Valor encontrado: $value');

          // Chama o repositório
          final days = await database.getDays();

          if (days.isEmpty) {
            print("--- Nenhuma tarefa encontrada no SQLite ---");
            return;
          }

          print("--- LISTANDO TAREFAS DO BANCO ---");
          for (var day in days) {
            print(
              "ID: ${day.id.toString()} | Título: ${day.date.toString()} | Valor: R\$ ${day.value.toString() } | Mês: ${day.mes_id.toString()}",
            );
          }
          print("---------------------------------");
        
      },
    );

    _loading = false;
    notifyListeners();
  }
}
