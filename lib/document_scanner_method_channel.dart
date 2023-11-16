import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'document_scanner_platform_interface.dart';

/// An implementation of [DocumentScannerPlatform] that uses method channels.
class MethodChannelDocumentScanner extends DocumentScannerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('document_scanner_flutter');

  @override
  Future<Uint8List?> getScannedImage() async {
    final filePath = await methodChannel.invokeMethod<Uint8List>('getScannedImage');
    return filePath;
  }
}
