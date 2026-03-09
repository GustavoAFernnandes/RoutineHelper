import 'package:flutter/material.dart';
import 'package:project/presentation-view/widgets-models/button_model.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool loading = false;
  Future beginOCR() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 10));
    setState(() => loading = false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: 
    
    ,
    child: ,
    )
    ButtonModel(
      height: 50,
      width: 300,
      onTap: () => beginOCR(),
      isLoading: loading,
    );
  }
}
