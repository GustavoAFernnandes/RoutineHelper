import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:project/data-model/repositories/OCR/RepositoryOCRImp.dart';

import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryOCR.dart';
import 'package:project/domain-viewModel/use_cases/OCR/readImage.dart';

class ReadImageImp implements ReadImage{
  @override
  Future<Either<ReadFailure, RecognizedText>> call({required String  path}) async {
     RepositoryOCRImp repositoryOCR = RepositoryOCRImp();
    return await repositoryOCR.Read(path: path);  
  }
 
}