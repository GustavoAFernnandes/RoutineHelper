import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/use_cases/OCR/getImage.dart';
import 'package:project/domain-viewModel/use_cases/OCR/readImage.dart';

class Buttonstate extends ChangeNotifier {
  Getimage getimageUseCase;
  ReadImage readImageUseCase;

  late bool _loading;

  bool get loading => _loading;

  Buttonstate({required this.getimageUseCase, required this.readImageUseCase});
  void beginOCR(){

    _loading = true;
    notifyListeners();
    String path = getimageUseCase.call(source: ImageSource.gallery ) as String;

    final lerImagem = readImageUseCase.call(path: path );

    _loading = false;
    notifyListeners();
  }
}