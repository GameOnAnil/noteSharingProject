import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

final fileGridNotifierProvider =
    ChangeNotifierProvider.family(((ref, String name) => FileGridNotifier()));

class FileGridNotifier extends ChangeNotifier {
  FirebaseStorage storage = FirebaseStorage.instance;
  double progress = 0;

  Future<List<String>> getFiles() async {
    final result = await storage.ref("docs").listAll();
    List<String> fileList = [];
    for (var r in result.items) {
      final url = await storage.ref(r.fullPath).getDownloadURL();
      fileList.add(url);
    }

    return fileList;
  }

  Future openFile({required String url, required String fileName}) async {
    final file = await downloadFile(url, fileName);
    if (file == null) return;
    log("file:${file.path}");
    try {
      await OpenFile.open(file.path);
    } catch (e) {
      log("openfile Error:$e");
    }
  }

  Future<File?> downloadFile(String url, String name) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File(".${appStorage.path}/$name");
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0), onReceiveProgress: (actual, total) {
        progress = actual / total * 100;
        notifyListeners();
      });

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      progress = 0;
      notifyListeners();
      return file;
    } catch (e) {
      rethrow;
    }
  }
}
