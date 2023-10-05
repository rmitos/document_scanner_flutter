import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'document_scanner_method_channel.dart';

abstract class DocumentScannerPlatform extends PlatformInterface {
  /// Constructs a DocumentScannerPlatform.
  DocumentScannerPlatform() : super(token: _token);

  static final Object _token = Object();

  static DocumentScannerPlatform _instance = MethodChannelDocumentScanner();

  /// The default instance of [DocumentScannerPlatform] to use.
  ///
  /// Defaults to [MethodChannelDocumentScanner].
  static DocumentScannerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DocumentScannerPlatform] when
  /// they register themselves.
  static set instance(DocumentScannerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Uint8List?> getScannedImage() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
