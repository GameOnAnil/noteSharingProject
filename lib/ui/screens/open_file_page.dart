import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class OpenFilePage extends StatefulWidget {
  final String filePath;
  const OpenFilePage({Key? key, required this.filePath}) : super(key: key);

  @override
  State<OpenFilePage> createState() => _OpenFilePageState();
}

class _OpenFilePageState extends State<OpenFilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Open File'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  openFile(
                    url:
                        "https://opengraph.githubassets.com/c09e331e20e8055bca600bad624e2dcd4f5bef8e887b9b91c180023f126e8fde/flutter/flutter/issues/48963",
                    fileName: "test",
                  );
                },
                child: const Text('Download'))
          ],
        ),
      ),
    );
  }

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file != null) {
      log("file:${file.path}");
      OpenFile.open(file.path);
    }
  }

  Future<File?> downloadFile(String url, String name) async {
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
  }
}
