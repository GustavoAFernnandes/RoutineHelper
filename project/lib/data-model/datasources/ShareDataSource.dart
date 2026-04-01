import 'dart:async';

import 'package:share_handler/share_handler.dart';

class Sharedatasource {
 final _handler = ShareHandler.instance;

  Stream<SharedMedia?> get shareStream => _handler.sharedMediaStream;

  Future<SharedMedia?> getInitialShare() => _handler.getInitialSharedMedia();
}