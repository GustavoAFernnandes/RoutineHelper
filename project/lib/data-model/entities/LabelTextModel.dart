import 'package:project/domain-viewModel/entities/LabelText.dart';

class Labeltextmodel extends Labeltext {
  String _labelText = "";
  String _labeldate = DateTime.now().toString().substring(0, 10);

  @override
  String get labelText => _labelText;

  @override
  String get labelTitleDate => _labeldate;
  
  set labelText(String novoValor) {
    if (novoValor.isNotEmpty) {
      _labelText = novoValor + " / 30";
    }
  }
}
