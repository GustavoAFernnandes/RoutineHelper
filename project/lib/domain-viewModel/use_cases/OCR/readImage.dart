import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

abstract class ReadImage {
  Future<Either<ReadFailure, RecognizedText>>call({required String  path});
}