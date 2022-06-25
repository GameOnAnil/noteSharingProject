import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:note_sharing_project/services/storage_service.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  File? _file;
  List<File> fileList = [];

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      _file = File(path);
    });
  }

  Future<void> selectMultipleFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files;
    setState(() {
      path.map((e) {
        fileList.add(File(e.path!));
      }).toList();
    });
  }

  Future<void> uploadFile() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Download Page"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                fileList = [];
                _file = null;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.download),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<String>> futureBuilder() {
    return FutureBuilder(
      future: StorageService().getFiles(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final currentFile = snapshot.data![index];
                  return Center(
                    child: Image.network(
                      currentFile,
                      width: 100,
                      height: 100,
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text("NULL"),
            );
          }
        }
        return const Center(child: Text("LOaging"));
      },
    );
  }

  SizedBox _downloadUpload() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: fileList.length,
              itemBuilder: (context, index) {
                final currentFile = fileList[index];

                return Center(
                    child: Image.file(
                  currentFile,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ));
              },
            ),
          ),
          (_file != null)
              ? Center(
                  child: Image.file(
                  _file!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ))
              : const Center(),
          ElevatedButton(
            onPressed: () {
              selectFile();
            },
            child: const Text("Select File"),
          ),
          ElevatedButton(
            onPressed: () {
              selectMultipleFile();
            },
            child: const Text("Select Multiple File"),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Upload File"),
          ),
        ],
      ),
    );
  }
}
