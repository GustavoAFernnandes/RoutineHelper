import 'dart:developer' as Developer;

import 'package:flutter/material.dart';
import 'package:project/data-model/datasources/ShareDataSource.dart';
import 'package:project/data-model/repositories/SharedFile/ShareRepositoryImpl.dart';
import 'package:project/data-model/use_cases/OCR/beginOCRImp.dart';
import 'package:project/data-model/use_cases/OCR/find_valueImp.dart';
import 'package:project/data-model/use_cases/OCR/getImageImp.dart';
import 'package:project/data-model/use_cases/OCR/readImageImp.dart';
import 'package:project/data-model/use_cases/SharedFile/getInitialShareImp.dart';
import 'package:project/data-model/use_cases/SharedFile/processImageImp.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryShared.dart';
import 'package:project/domain-viewModel/use_cases/OCR/beginOCR.dart';
import 'package:project/domain-viewModel/use_cases/OCR/find_value.dart';
import 'package:project/domain-viewModel/use_cases/OCR/getImage.dart';
import 'package:project/domain-viewModel/use_cases/OCR/readImage.dart';
import 'package:project/domain-viewModel/use_cases/SharedFile/getInitialShare.dart';
import 'package:project/domain-viewModel/use_cases/SharedFile/processImage.dart';
import 'package:project/presentation-view/providers/buttonProvider.dart';
import 'package:project/presentation-view/state/buttonState.dart';
import 'package:project/presentation-view/state/imageSharedState.dart';
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
      Provider<BeginOCR>(
        create: (context) => BeginOCRImp(
          context.read<Getimage>(),
          context.read<ReadImage>(),
          context.read<FindValue>(),
        ),
      ),

      ChangeNotifierProvider<Buttonstate>(
        create: (context) =>
            Buttonstate(beginOCRUseCase: context.read<BeginOCR>()),
      ),

      Provider<Sharedatasource>(create: (_) => Sharedatasource()),

      ProxyProvider<Sharedatasource, Repositoryshared>(
        update: (_, dataSource, _) => ShareRepositoryImpl(dataSource),
      ),

      ProxyProvider<Repositoryshared, Processimage>(
        update: (_, repository, _) => ProcessimageImp(repository),
      ),

      ChangeNotifierProvider<Imagesharedstate>(
        lazy: false,
        create: (context) => Imagesharedstate(
          getSharedImage: context.read<Processimage>(),
          processOcr: context.read<BeginOCR>(),
        ),
      ),
    ],
    child: child,
  );
}
