import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:document_scanner/document_scanner.dart';
import 'package:document_scanner/document_scanner_platform_interface.dart';
import 'package:document_scanner/document_scanner_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDocumentScannerPlatform
    with MockPlatformInterfaceMixin
    implements DocumentScannerPlatform {

  @override
  Future<Uint8List?> getScannedImage() => Future.value(null);
}

void main() {
  final DocumentScannerPlatform initialPlatform = DocumentScannerPlatform.instance;

  test('$MethodChannelDocumentScanner is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDocumentScanner>());
  });

  test('getScannedImage', () async {
    DocumentScanner documentScannerPlugin = DocumentScanner();
    MockDocumentScannerPlatform fakePlatform = MockDocumentScannerPlatform();
    DocumentScannerPlatform.instance = fakePlatform;

    expect(await documentScannerPlugin.getScannedImage(), null);
  });
}
