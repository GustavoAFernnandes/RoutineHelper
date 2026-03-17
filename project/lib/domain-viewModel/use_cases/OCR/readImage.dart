import 'package:dartz/dartz.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

abstract class ReadImage {
  Future<Either<BeginOCRFailure, String>>call({required String  path});
}