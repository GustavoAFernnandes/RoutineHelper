import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/use_cases/OCR/find_value.dart';

class FindValueimp implements FindValue {
  @override
  Future<Either<FailureFindValue, double>> call({
    required RecognizedText recognizedText,
  }) async {
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
}
