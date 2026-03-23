import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

abstract class FindValue {
  Future<Either<FailureFindValue, String>> call({required RecognizedText recognizedText});
}