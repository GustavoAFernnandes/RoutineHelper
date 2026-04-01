import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'getImage.dart';
import 'readImage.dart';
import '../../erros/OCR/failure.dart';

abstract class BeginOCR {
  Future<Either<BeginOCRFailure, String>> call({ ImageSource ?source,  String ?path});
}