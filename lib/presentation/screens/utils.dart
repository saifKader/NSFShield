import 'dart:io';

import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScannerUtil {
  static Future<File?> startScan(BuildContext context) async {
    try {
      final image = await DocumentScannerFlutter.launch(context);
      return image;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scanning error: $e')),
      );
      return null;
    }
  }
}
