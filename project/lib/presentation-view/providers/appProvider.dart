import 'package:flutter/material.dart';
import 'package:project/data-model/use_cases/OCR/beginOCRImp.dart';
import 'package:project/data-model/use_cases/OCR/find_valueImp.dart';
import 'package:project/data-model/use_cases/OCR/getImageImp.dart';
import 'package:project/data-model/use_cases/OCR/readImageImp.dart';
import 'package:project/domain-viewModel/use_cases/OCR/find_value.dart';
import 'package:project/domain-viewModel/use_cases/OCR/getImage.dart';
import 'package:project/domain-viewModel/use_cases/OCR/readImage.dart';
import 'package:project/presentation-view/providers/buttonProvider.dart';
import 'package:project/presentation-view/state/buttonState.dart';
import 'package:project/presentation-view/ui/home_page.dart';
import 'package:provider/provider.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider<Getimage>(create: (context) => Getimageimp()),
      Provider<ReadImage>(create: (context) => ReadImageImp()),
      Provider<FindValue>(create: (context) => FindValueimp()),
      ChangeNotifierProvider<Buttonstate>(
        create: (context) => Buttonstate(
          beginOCRUseCase: BeginOCRImp(
            context.read<Getimage>(),
            context.read<ReadImage>(),
            context.read<FindValue>(),
          ),
        ),
      ),
    ],
    child: child,
  );
}
