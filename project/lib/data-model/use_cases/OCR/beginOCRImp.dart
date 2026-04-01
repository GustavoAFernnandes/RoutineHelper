import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/data-model/repositories/OCR/RepositoryOCRImp.dart';
import 'package:project/data-model/use_cases/OCR/find_valueImp.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryOCR.dart';
import 'package:project/domain-viewModel/use_cases/OCR/beginOCR.dart';
import 'package:project/domain-viewModel/use_cases/OCR/find_value.dart';
import 'package:project/domain-viewModel/use_cases/OCR/getImage.dart';
import 'package:project/domain-viewModel/use_cases/OCR/readImage.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';

class BeginOCRImp implements BeginOCR {
  final Getimage getimage;
  final ReadImage readImage;
  final FindValue findValue;

  BeginOCRImp(this.getimage, this.readImage, this.findValue);

  @override
  Future<Either<BeginOCRFailure, String>> call({ImageSource ?source, String ?path}) async {
    RepositoryOCRImp repositoryOCR = RepositoryOCRImp();
    return await repositoryOCR.beginOCR(source: source, path: path);
  }
}