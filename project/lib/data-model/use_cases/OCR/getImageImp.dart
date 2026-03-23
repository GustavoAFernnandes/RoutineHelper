import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/use_cases/OCR/getImage.dart';

class Getimageimp implements Getimage{
  @override
  Future<Either<GetImageFailure, String>> call({required ImageSource source}) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: source);
      return Right(pickedImage!.path);
    } catch (e) {
      return Left(GetImageFailure(e.toString()));
    }
    

  }
  
}