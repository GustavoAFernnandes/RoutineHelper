import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'getImage.dart';
import 'readImage.dart';
import '../../erros/OCR/failure.dart';

abstract class BeginOCR {
  Future<Either<BeginOCRFailure, String>> call({required ImageSource source});
}