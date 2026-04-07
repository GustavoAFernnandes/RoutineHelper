import 'package:flutter/material.dart';
import 'package:project/core/database_helper.dart';
import 'package:project/data-model/datasources/local_database.dart';
import 'package:project/data-model/repositories/OCR/RepositoryOCRImp.dart';
import 'package:project/data-model/repositories/database/RepositoryDataBaseImp.dart';
import 'package:project/data-model/use_cases/OCR/beginOCRImp.dart';
import 'package:project/data-model/use_cases/OCR/find_valueImp.dart';
import 'package:project/data-model/use_cases/OCR/getImageImp.dart';
import 'package:project/data-model/use_cases/OCR/readImageImp.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryDataBase.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryOCR.dart';
import 'package:project/domain-viewModel/use_cases/OCR/beginOCR.dart';
import 'package:project/domain-viewModel/use_cases/OCR/find_value.dart';
import 'package:project/domain-viewModel/use_cases/OCR/getImage.dart';
import 'package:project/domain-viewModel/use_cases/OCR/readImage.dart';
import 'package:project/presentation-view/state/buttonState.dart';
import 'package:provider/provider.dart';

class ButtonProvider extends StatelessWidget {
  final Widget widget;
  const ButtonProvider({super.key, required this.widget});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider<Getimage>(create: (context) => Getimageimp()),
      Provider<ReadImage>(create: (context) => ReadImageImp()),
      Provider<FindValue>(create: (context) => FindValueimp()),

      Provider<RepositoryOCR>(create: (context) => RepositoryOCRImp()),
      Provider<BeginOCR>(
        create: (context) => BeginOCRImp(
          context.read<Getimage>(),
          context.read<ReadImage>(),
          context.read<FindValue>(),
          context.read<RepositoryOCR>(),
        ),
      ),
      Provider<ITaskRepository>(
        create: (context) =>
            TaskRepositoryImpl(TaskLocalDataSource(DatabaseHelper())),
      ),
      ChangeNotifierProvider(
        create: (context) => Buttonstate(
          beginOCRUseCase: context.read<BeginOCR>(),
          database: context.read<ITaskRepository>(),
        ),
      ),
    ],
    child: widget,
  );
}
