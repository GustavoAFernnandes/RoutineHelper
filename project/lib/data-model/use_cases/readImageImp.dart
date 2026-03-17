import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/use_cases/OCR/readImage.dart';

class ReadImageImp implements ReadImage{
  @override
  Future<Either<BeginOCRFailure, String>> call({required String  path}) async {
     TextRecognizer T = TextRecognizer(script: TextRecognitionScript.latin);
      

    try {
      final inputImage = InputImage.fromFilePath(path);
      final RecognizedText recognisedText =
          await T.processImage(inputImage);

      String text ="";

      for (TextBlock block in recognisedText.blocks) {
        for (TextLine line in block.lines) {
          text += "${line.text}\n";
        }
      }
      return Right(text);
    } catch (e) {
     
      return Left(BeginOCRFailure(e.toString()));
      
    } 
  }
 
}