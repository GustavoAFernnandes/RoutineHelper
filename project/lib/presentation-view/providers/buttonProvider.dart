import 'package:flutter/material.dart';
import 'package:project/data-model/use_cases/getImageImp.dart';
import 'package:project/data-model/use_cases/readImageImp.dart';
import 'package:project/domain-viewModel/use_cases/OCR/getImage.dart';
import 'package:project/domain-viewModel/use_cases/OCR/readImage.dart';
import 'package:provider/provider.dart';

class ButtonProvider extends StatelessWidget {
  final Widget widget;
  const ButtonProvider({super.key, required this.widget });

  @override
  Widget build(BuildContext context) => MultiProvider(providers: [
    Provider<Getimage>(create: (context) => Getimageimp()),
    Provider<ReadImage>(create: (context) => ReadImageImp())
  ],
  child: widget,
  );
}