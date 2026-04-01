import 'dart:developer' as Developer;

import 'package:project/data-model/datasources/ShareDataSource.dart';
import 'package:project/domain-viewModel/entities/ImageShared.dart';
import 'package:project/domain-viewModel/repositories-interfaces/RepositoryShared.dart';

class ShareRepositoryImpl implements Repositoryshared {
 final Sharedatasource dataSource;

  ShareRepositoryImpl(this.dataSource);

  @override
  Stream<ImageShared> watchSharedImages() {
    Developer.log("Teste De whatcharedImages: ${dataSource.shareStream}");
    return dataSource.shareStream
        .where((media) => media != null && media.attachments != null)
        .map((media) => ImageShared(
              path: media!.attachments!.first!.path,
            ));
  }

  @override
  Future<ImageShared?> getInitialImage() async {
    Developer.log("Teste De getInitialImage: ${dataSource.getInitialShare()}");
    final media = await dataSource.getInitialShare();
    if (media?.attachments != null) {
      return ImageShared(path: media!.attachments!.first!.path);
    }
    return null;
  }
}