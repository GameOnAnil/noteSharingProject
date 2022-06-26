import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> getFiles() async {
    final result = await storage.ref("docs").listAll();
    List<String> fileList = [];
    for (var r in result.items) {
      final url = await storage.ref(r.fullPath).getDownloadURL();
      fileList.add(url);
    }

    return fileList;
  }

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
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
      final file = File("${appStorage.path}/$name");
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      log("downloadFileEROR:$e");
      rethrow;
    }
  }
}
