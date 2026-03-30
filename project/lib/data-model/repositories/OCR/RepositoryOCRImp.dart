import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_text_recognition/src/text_recognizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryOCR.dart';

class RepositoryOCRImp implements RepositoryOCR {
  
  @override
  Future<Either<GetImageFailure, String>> GetImage({required ImageSource source}) async {
     try {
      ImagePicker imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: source);
      return Right(pickedImage!.path);
    } catch (e) {
      return Left(GetImageFailure(e.toString()));
    }
    
  }

  @override
  Future<Either<ReadFailure, RecognizedText>> Read({required String path}) async {
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
      T.close();
      return Right(recognisedText);
    } catch (e) {
      T.close();
      return Left(ReadFailure(e.toString()));
      
    } 
  }

  @override
  Future<Either<FailureFindValue, double>> findValue({required RecognizedText recognizedText}) async {
    // Regex que busca "Total", "Valor Total" ou "Soma", seguido de R$ e o valor
    // (?i) torna a busca case-insensitive (total ou TOTAL)
    // \s* aceita espaços variáveis
    final RegExp regexTotal = RegExp(
      r'(?:Total|Valor Total|Subtotal)\s*:?\s*R\$\s?(\d{1,3}(?:\.\d{3})*,\d{2})',
      caseSensitive: false,
    );

    try {
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          final match = regexTotal.firstMatch(line.text);

          if (match != null) {
            // Captura apenas o grupo numérico (ex: 150,00)
            String valorString = match.group(1)!;

            // Converte para o padrão double do Dart
            valorString = valorString.replaceAll('.', '').replaceAll(',', '.');

            double? valorNumerico = double.tryParse(valorString);

            if (valorNumerico != null) {
              // Retorna o primeiro "Total" encontrado e encerra a busca
              return Right(valorNumerico);
            }
          }
        }
      }
      print(recognizedText.text);
      try {
      
      final matches = RegExp(
        r'R\$\s?(\d{1,3}(?:\.\d{3})*,\d{2})',
      ).allMatches(recognizedText.text);
      if (matches.isNotEmpty) {
        final ultimoValor = matches.last.group(1);
        return Right(double.parse(ultimoValor!.replaceAll('.', '').replaceAll(',', '.')));
       
      }
      } catch (e) {
        print("Erro ao procurar valor: $e");
      }
      
      return Left(
        FailureFindValue("Campo 'Valor Total' não encontrado no texto."),
      );
    } catch (e) {
      return Left(FailureFindValue(e.toString()));
    }
  }
  
  @override
  Future<Either<BeginOCRFailure, String>> beginOCR({required ImageSource source}) async {
   final imageResult = await GetImage.call(source: source);
    return imageResult.fold(
      (failure) => Left(BeginOCRFailure(failure.message)),
      (path) async {
        final readResult = await Read.call(path: path);
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