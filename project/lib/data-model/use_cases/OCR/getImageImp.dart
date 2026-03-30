import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/data-model/repositories/OCR/RepositoryOCRImp.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryOCR.dart';
import 'package:project/domain-viewModel/use_cases/OCR/getImage.dart';

class Getimageimp implements Getimage{
  @override
  Future<Either<GetImageFailure, String>> call({required ImageSource source}) async {
   RepositoryOCRImp repositoryOCR = RepositoryOCRImp();
    return await repositoryOCR.GetImage(source: source);

  }
  
}