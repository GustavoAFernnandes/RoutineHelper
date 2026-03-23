import 'package:flutter/material.dart';
import 'package:project/data-model/use_cases/OCR/getImageImp.dart';
import 'package:project/data-model/use_cases/OCR/readImageImp.dart';
import 'package:project/presentation-view/providers/buttonProvider.dart';
import 'package:project/presentation-view/state/buttonState.dart';
import 'package:project/presentation-view/widgets-models/button_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: ButtonWidget(),
            
          ),
        ),
      ),
    );
  }
}

