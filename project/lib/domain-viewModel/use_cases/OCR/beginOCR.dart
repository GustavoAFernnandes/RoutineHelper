import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../erros/OCR/failure.dart';

abstract class BeginOCR {
  Future<Either<BeginOCRFailure, String>> call({ ImageSource ?source,  String ?path});
}