import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:document_scanner/document_scanner_method_channel.dart';

void main() {
  MethodChannelDocumentScanner platform = MethodChannelDocumentScanner();
  const MethodChannel channel = MethodChannel('document_scanner');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getScannedImage', () async {
    expect(await platform.getScannedImage(), '');
  });
}
