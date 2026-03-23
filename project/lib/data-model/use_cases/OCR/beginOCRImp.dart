import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/data-model/use_cases/OCR/find_valueImp.dart';
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
  Future<Either<BeginOCRFailure, String>> call({required ImageSource source}) async {
    final imageResult = await getimage.call(source: source);
    return imageResult.fold(
      (failure) => Left(BeginOCRFailure(failure.message)),
      (path) async {
        final readResult = await readImage.call(path: path);
        return readResult.fold(
          (failure) => Left(BeginOCRFailure(failure.message)),
          (recognizedText) async {
            final findResult = await findValue.call(recognizedText: recognizedText);
            return findResult.fold(
              (failure) => Left(BeginOCRFailure(failure.message)),
              (value) => Right(value.toString()),
            );
          },
        );
      },
    );
  }
}