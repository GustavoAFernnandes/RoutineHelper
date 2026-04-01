import 'dart:async';
import 'dart:developer' as Developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/data-model/entities/SharedAttachmentModel.dart';
import 'package:project/data-model/use_cases/OCR/getImageImp.dart';
import 'package:project/data-model/use_cases/OCR/readImageImp.dart';
import 'package:project/domain-viewModel/entities/ImageShared.dart';
import 'package:project/presentation-view/providers/buttonProvider.dart';
import 'package:project/presentation-view/state/buttonState.dart';
import 'package:project/presentation-view/state/imageSharedState.dart';
import 'package:project/presentation-view/widgets-models/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_handler/share_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedMedia? sharedMedia;
  // Para armazenar a última mídia recebida via Stream
  //  StreamSubscription<SharedMedia>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    requestPermissions();
    // initPlatformState();
  }

  // Future<void> initPlatformState() async {
  //   final handler = ShareHandler.instance;

  //   // 1. Captura se o app foi aberto VIA compartilhamento (App estava fechado)
  //   final initialMedia = await handler.getInitialSharedMedia();
  //   if (initialMedia != null) {
  //     _processarArquivo(initialMedia);
  //   }

  //   // 2. ESCUTA EM TEMPO REAL (App em background/aberto)
  //   _streamSubscription = handler.sharedMediaStream.listen((SharedMedia media) {
  //     print("Nova mídia recebida via Stream!");
  //     _processarArquivo(media);
  //   });
  // }

  // void _processarArquivo(SharedMedia media) {
  //   if (media.attachments != null && media.attachments!.isNotEmpty) {
  //     for (var file in media.attachments!) {
  //       print("Arquivo encontrado: ${file?.path}");
  //       setState(() {
  //         sharedAttachment = file;
  //         path = file?.path; // Armazena a última mídia recebida
  //       });
  //       // AQUI você usa o path. Se for null aqui, o problema é permissão.
  //     }
  //   } else {
  //     print("Objeto media recebido, mas sem anexos.");
  //   }
  // }

  // @override
  // void dispose() {
  //   _streamSubscription?.cancel();
  //   super.dispose();
  // }
  Future<void> requestPermissions() async {
    // Para Android 13+, usamos photos. Para anteriores, usamos storage.
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
      print("Permissão concedida!");
    } else {
      print("Permissão negada. O app não conseguirá ler a imagem.");
      // Opcional: Abrir as configurações do sistema para o usuário permitir manualmente
      // openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageModel?
    image = context.select<Imagesharedstate, ImageModel?>(
      (state) => state
          .image, // Substitua 'attachment' pelo nome da variável no seu estado
    );
    bool?
    loading = context.select<Imagesharedstate, bool?>(
      (state) => state
          .isProcessing, // Substitua 'attachment' pelo nome da variável no seu estado
    );
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: loading! ? CircularProgressIndicator() : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image?.path != null)
                Image.file(File(image!.path), height: 300)
              else
                Text("Nenhuma imagem compartilhada ainda."),

              Align(child: ButtonWidget(), alignment: AlignmentGeometry.center),
            ],
          ),
        ),
      ),
    );
  }
}
