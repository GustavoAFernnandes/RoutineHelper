import 'dart:developer' as Developer;

import 'package:dartz/dartz.dart';
import 'package:project/data-model/repositories/SharedFile/ShareRepositoryImpl.dart';
import 'package:project/domain-viewModel/entities/LabelText.dart';
import 'package:project/domain-viewModel/entities/ImageShared.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryShared.dart';
import 'package:project/domain-viewModel/use_cases/SharedFile/processImage.dart';
import 'package:share_handler_platform_interface/src/data/messages.dart';

class ProcessimageImp extends Processimage {
  final Repositoryshared repository;

  ProcessimageImp(this.repository);

  @override
  Future<Either<Failure, ImageShared>> call() async {
    Developer.log("Teste De ProcessimageImp: ${repository.getInitialImage()}");
    try {
      final initialMedia = await repository.getInitialImage();
      if (initialMedia != null) {
        return Right(initialMedia);
      }
      Developer.log(
        "Teste De ProcessimageImp: ${repository.watchSharedImages().first}",
      );
      final result = await repository.watchSharedImages().first;
      return Right(result);
    } catch (e) {
      return Left(SharedFileFailure("Failed to process image"));
    }
  }
}
