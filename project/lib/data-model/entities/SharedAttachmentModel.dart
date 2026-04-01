
import 'package:share_handler/share_handler.dart';

class ImageModel {

  final String path;
 
  final String type;

  ImageModel({required this.path, required this.type});

  // Converte o objeto complexo do plugin para algo simples
  factory ImageModel.fromSharedMedia(SharedMedia media) {
    return ImageModel(
      path: media.attachments?.first?.path ?? '',
      type: media.attachments?.first?.type.name ?? 'image',
    );
  }
}