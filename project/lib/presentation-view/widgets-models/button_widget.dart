import 'package:flutter/material.dart';
import 'package:project/presentation-view/state/buttonState.dart';
import 'package:project/presentation-view/widgets-models/button_model.dart';
import 'package:provider/provider.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  late Buttonstate provider = context.watch<Buttonstate>();
  @override
  Widget build(BuildContext context) {
    
    return  ButtonModel(
      height: 50,
      width: 300,
      onTap: () => provider.beginOCR(),
      isLoading: provider.loading,
    );
    
  }
}
