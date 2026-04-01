import 'package:dartz/dartz.dart';
import 'package:project/data-model/repositories/SharedFile/ShareRepositoryImpl.dart';
import 'package:project/domain-viewModel/entities/ImageShared.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/use_cases/SharedFile/getInitialShare.dart';

class GetInitialShareUseCaseImp extends GetInitialShareUseCase {
  GetInitialShareUseCaseImp(super.repository);

  @override
  Future<Either<SharedFileFailure, ImageShared?>> execute() async {
    try {
      final result = await repository.getInitialImage();
      return Right(result);
    } catch (e) {
      return Left(SharedFileFailure(e.toString()));
    }
  }
}
