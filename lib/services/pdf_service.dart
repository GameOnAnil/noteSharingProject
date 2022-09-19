import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFService {
  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();

    return _storeFile(path, bytes, "");
  }

  static Future<File> loadNetwork(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes, fileName);
  }

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return null;
    return File(result.paths.first ?? "");
  }

  static Future<File?> loadFirebase(String url, String fileName) async {
    try {
      final refPDF = FirebaseStorage.instance.refFromURL(url);
      final bytes = await refPDF.getData();

      return _storeFile(url, bytes ?? [], fileName);
    } catch (e) {
      rethrow;
    }
  }

  static Future<File> _storeFile(
      String url, List<int> bytes, String fileName) async {
    // final filename = basename(url);

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
