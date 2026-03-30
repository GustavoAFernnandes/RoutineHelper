import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/domain-viewModel/use_cases/OCR/beginOCR.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

class Buttonstate extends ChangeNotifier {
  final BeginOCR beginOCRUseCase;

    bool _loading = false;
   
    bool get loading => _loading;

  Buttonstate({required this.beginOCRUseCase});
  Future<void> beginOCR() async {
    print('Iniciando OCR');
    _loading = true;
    notifyListeners();
    print('Loading set to true');

    final result = await beginOCRUseCase.call(source: ImageSource.gallery);
    result.fold(
      (failure) {
        print('Erro: ${failure.message}');
      },
      (value) {
        print('Valor encontrado: $value');
      },
    );
    
    _loading = false;
    notifyListeners();
  }
}