import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:document_scanner/document_scanner.dart';

void main() {
  PlatformDispatcher.instance.onError = (error, stack) {
    log("Error from Android Platform:::$error");
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _documentScannerPlugin = DocumentScanner();
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text("Scan Document"),
                    onPressed: () async {
                      final content =
                          await _documentScannerPlugin.getScannedImage();
                      if (content != null) {
                        setState(() {
                          _image = content;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(child: const Text("Clear"), onPressed: (){
                    setState(() {
                      _image = null;
                    });
                  },),
                ],
              ),
              _image == null ? const SizedBox.shrink() : Image.memory(_image!)
            ],
          ),
        ),
      ),
    );
  }
}
