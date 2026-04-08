// lib/features/todo_list/data/datasources/task_local_datasource.dart
import 'dart:developer' as developer;

import 'package:project/data-model/entities/DiaModel.dart';
import 'package:project/data-model/entities/mesModel.dart';

import '../../core/database_helper.dart';

class TaskLocalDataSource {
  final DatabaseHelper dbHelper;
  TaskLocalDataSource(this.dbHelper);
  // No seu TaskLocalDataSource ou Repository
  Future<int> _obterMesId(int mes, String ano) async {
    final db = await dbHelper.database;
    const List<String> meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    // Buscamos o mês específico
    final List<Map<String, dynamic>> result = await db.query(
      'meses',
      columns: ['id'],
      where: 'nome_mes = ? AND ano = ?',
      whereArgs: [meses[mes-1], ano],
    );

    if (result.isNotEmpty) {
      
      developer.log('Mês encontrado: ${meses[mes-1]} de $ano com ID ${result.first['id']}');
      return result.first['id'] as int;
    } else {
      throw Exception("Mês $mes de $ano não encontrado no banco!");
    }
  }

  Future<List<Map<String, dynamic>>> getDays() async {
    final db = await dbHelper.database;
    return await db.query('dias'); // SELECT * FROM tasks
  }

  // Exemplo de fluxo no seu Data Source ou Repository
  Future<void> salvarDia(DiaModel dia, DateTime date) async {
    final db = await dbHelper.database;

    final int idDoMesNoBanco = await _obterMesId(
      date.month,
      date.year.toString(),
    );
    // 2. Salva o dia passando o mesId
    await db.insert('dias', {
      'date': dia.date.toIso8601String(),
      'value': dia.value,
      'mes_id': idDoMesNoBanco,
    });
  }

  Future<List<Map<String, dynamic>>> buscarDiasPorMesEAno(int mesId) async {
    final db = await dbHelper.database;

    return await db.rawQuery(
      '''
    SELECT d.* FROM dias d
    INNER JOIN meses m ON d.mes_id = m.id
    WHERE m.id = ?
  ''',
      [mesId],
    );
  }
}
