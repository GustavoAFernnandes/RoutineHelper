// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project/data-model/datasources/ShareDataSource.dart';
import 'package:project/data-model/repositories/SharedFile/ShareRepositoryImpl.dart';

import 'package:project/main.dart';
import 'package:share_handler/share_handler.dart';
// AQUI ESTÁ A DEFINIÇÃO QUE FALTAVA:
class MockSharedatasource extends Mock implements Sharedatasource {}
void main() {
  test('Deve converter SharedMedia em SharedContent com sucesso', () async {
    // 1. Criamos um Mock do DataSource (simulando o plugin)
    final mockDataSource = MockSharedatasource();
    final repository = ShareRepositoryImpl(mockDataSource);

    // 2. Simulamos o plugin enviando uma imagem
    final fakeMedia = SharedMedia(attachments: [SharedAttachment(path: 'foto.jpg', type: SharedAttachmentType.image)]);
    when(() =>mockDataSource.shareStream).thenAnswer((_) => Stream.value(fakeMedia));

    // 3. Executamos o método do repositório
    final result = await repository.watchSharedImages().first;

    // 4. Verificamos se o path chegou certo
    expect(result.filePath, 'foto.jpg');
  });
}
