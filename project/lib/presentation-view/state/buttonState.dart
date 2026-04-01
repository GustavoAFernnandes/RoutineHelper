import 'dart:developer' as Developer show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/domain-viewModel/use_cases/OCR/beginOCR.dart';

class Buttonstate extends ChangeNotifier {
  final BeginOCR beginOCRUseCase;

  bool _loading = false;

  bool get loading => _loading;

  Buttonstate({required this.beginOCRUseCase});
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
      (value) {
        Developer.log(name: "OCR", 'Valor encontrado: $value');
      },
    );

    _loading = false;
    notifyListeners();
  }
}
