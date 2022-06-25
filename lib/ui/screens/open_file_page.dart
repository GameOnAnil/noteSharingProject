import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:note_sharing_project/services/storage_service.dart';
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
            Expanded(
              child: FutureBuilder(
                  future: StorageService().getFiles(),
                  builder: (context, AsyncSnapshot<List<String>?> snapshot) {
                    if (snapshot.data != null) {
                      final datalist = snapshot.data;
                      return ListView.builder(
                        itemCount: datalist?.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () async {
                              openFile(
                                  url: datalist![index], fileName: "abc.jpeg");
                            },
                            child: ListTile(
                              title: Text(datalist![index]),
                            ),
                          );
                        }),
                      );
                    }

                    return Center(
                      child: Text("empty"),
                    );
                  }),
            ),
            ElevatedButton(
                onPressed: () async {
                  final downloadUrl = await FirebaseStorage.instance
                      .ref("/docs/ApplicationDetails.pdf")
                      .getDownloadURL();
                  log("url:$downloadUrl");
                  openFile(
                    url: downloadUrl,
                    fileName: "ApplicationDetails.pdf",
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
