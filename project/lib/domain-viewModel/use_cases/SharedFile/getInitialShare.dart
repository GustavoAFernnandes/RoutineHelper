import 'package:dartz/dartz.dart';
import 'package:project/data-model/repositories/SharedFile/ShareRepositoryImpl.dart';
import 'package:project/domain-viewModel/entities/ImageShared.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

abstract class GetInitialShareUseCase {
  final ShareRepositoryImpl repository;

  GetInitialShareUseCase(this.repository);

  Future<Either<SharedFileFailure,ImageShared?>> execute();
} 