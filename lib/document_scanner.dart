
import 'dart:typed_data';

import 'document_scanner_platform_interface.dart';

class DocumentScanner {
  Future<Uint8List?> getScannedImage() {
    return DocumentScannerPlatform.instance.getScannedImage();
  }
}
