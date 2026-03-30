

import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

abstract class RepositoryOCR {
  Future<Either<BeginOCRFailure, String>> beginOCR({required ImageSource source});
  Future<Either<ReadFailure, RecognizedText>> Read({required String  path});
  Future<Either<GetImageFailure, String>> GetImage({required ImageSource source});
  Future<Either<FailureFindValue, double>> findValue({required RecognizedText recognizedText});

}