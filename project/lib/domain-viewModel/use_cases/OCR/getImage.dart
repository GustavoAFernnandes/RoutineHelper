import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

abstract class Getimage {
  Future<Either<GetImageFailure,String>> call({required ImageSource source});
}