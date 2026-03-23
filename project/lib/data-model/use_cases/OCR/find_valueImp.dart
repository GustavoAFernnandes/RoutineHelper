import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:project/domain-viewModel/erros/OCR/failure.dart';
import 'package:project/domain-viewModel/use_cases/OCR/find_value.dart';

class FindValueimp implements FindValue {
 @override
Future<Either<FailureFindValue, String>> call({
  required RecognizedText recognizedText,
}) async {
  // Nota: Se você já recebe o recognizedText por parâmetro, 
  // não precisa instanciar ou fechar o TextRecognizer aqui dentro.
  
  final RegExp regexPreco = RegExp(r'R\$\s?(\d{1,3}(?:\.\d{3})*,\d{2})');
  double totalSoma = 0.0;

  try {
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        final matches = regexPreco.allMatches(line.text);

        for (var match in matches) {
          // 1. Pega apenas o grupo numérico (ex: "1.250,50")
          String valorLimpo = match.group(1)!;

          // 2. Transforma para formato double (ex: "1250.50")
          valorLimpo = valorLimpo.replaceAll('.', '').replaceAll(',', '.');
          
          double? valorNumerico = double.tryParse(valorLimpo);
          
          if (valorNumerico != null) {
            totalSoma += valorNumerico;
          }
        }
      }
    }

    // Retorna formatado novamente como R$ (ex: 1500.5 -> "R$ 1500,50")
    // Use toStringAsFixed(2) para garantir os centavos
    String resultadoFormatado = "R\$ ${totalSoma.toStringAsFixed(2).replaceAll('.', ',')}";
    
    return Right(resultadoFormatado);
    
  } catch (e) {
    return Left(FailureFindValue(e.toString()));
  }
}
}
