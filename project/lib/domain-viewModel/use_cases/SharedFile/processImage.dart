import 'package:dartz/dartz.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

abstract class Processimage {
  //TODO: planejar que tipo ele retornara e qual ele receberá
  Future<Either<Failure, ReturnType>> call({required ParameterType parameter}); 
}