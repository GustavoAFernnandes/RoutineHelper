import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:project/data-model/repositories/OCR/RepositoryOCRImp.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/use_cases/OCR/find_value.dart';

class FindValueimp implements FindValue {
  @override
  Future<Either<FailureFindValue, double>> call({
    required RecognizedText recognizedText,
  }) async {
    RepositoryOCRImp repositoryOCR = RepositoryOCRImp();
    return await repositoryOCR.findValue(recognizedText: recognizedText);
  }
}
