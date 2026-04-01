import 'package:dartz/dartz.dart';
import 'package:project/domain-viewModel/entities/ImageShared.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

abstract class Processimage {
  Future<Either<Failure, ImageShared>> call(); 
}