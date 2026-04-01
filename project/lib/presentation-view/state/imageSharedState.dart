import 'dart:developer' as Developer;
import 'package:flutter/material.dart';
import 'package:project/data-model/entities/SharedAttachmentModel.dart';
import 'package:project/domain-viewModel/entities/ImageShared.dart';
import 'package:project/domain-viewModel/use_cases/OCR/beginOCR.dart';
import 'package:project/domain-viewModel/use_cases/SharedFile/processImage.dart';

class Imagesharedstate extends ChangeNotifier {
  final Processimage getSharedImage;
  final BeginOCR processOcr;

  ImageModel? image;
  bool isProcessing = false;

  Imagesharedstate({required this.getSharedImage, required this.processOcr}) {
    Developer.log("Teste De Imagesharedstate: ${getSharedImage.call()}");
    _listenToSharing();
  }

  void _listenToSharing() {
    getSharedImage.call().then((either) {
      either.fold(
        (failure) {
          Developer.log(
            'Erro ao obter imagem compartilhada: ${failure.message}',
          );
        },
        (content) {
          _handleNewImage(content.path);
        },
      );
    });
  }

  void _handleNewImage(String path) async {
    image = ImageModel(path: path, type: 'image');
    isProcessing = true;
    notifyListeners();

    await processOcr.call(path: path);

    isProcessing = false;
    notifyListeners();
  }
}
