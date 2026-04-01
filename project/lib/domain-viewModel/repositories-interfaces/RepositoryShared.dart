import 'package:project/domain-viewModel/entities/ImageShared.dart';

abstract class Repositoryshared {
  Stream<ImageShared> watchSharedImages();
  Future<ImageShared?> getInitialImage();
}
