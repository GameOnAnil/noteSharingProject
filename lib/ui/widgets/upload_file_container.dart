import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class UploadFileContainer extends StatelessWidget {
  final File? mFile;
  final Function(File file, String name, String size) changeFile;
  final Function() removePicked;
  final String name;
  final String size;

  const UploadFileContainer({
    Key? key,
    required this.changeFile,
    this.mFile,
    required this.removePicked,
    required this.name,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final response = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          // type: FileType.custom,
          // allowedExtensions: ["png", "jpg", "jpeg"],
        );
        if (response == null) return;

        final file = response.files.first;
        file.name;
        final size = await getFileSize(file.size, 2);

        if (file.path != null) {
          changeFile(File(file.path!), file.name, size);
        }
      },
      child: (mFile == null) ? _noFile() : _hasFile(),
    );
  }

  Future<String> getFileSize(int raw, int decimals) async {
    if (raw <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(raw) / log(1024)).floor();
    return '${(raw / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  Widget _hasFile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 10),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 100, height: 150, child: _getLogo()),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRichText("Name: ", name),
                          _buildRichText("Size: ", size),
                          _buildRichText(
                              "File Type: ", ".${name.split('.')[1]}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _removeFileButton()
        ],
      ),
    );
  }

  RichText _buildRichText(String title, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: darkBlueBackground,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getLogo() {
    final fileType = name.split('.')[1];
    switch (fileType) {
      case "jpeg":
        return Image.file(mFile!, fit: BoxFit.cover);
      case "png":
        return Image.file(mFile!, fit: BoxFit.cover);
      case "jpg":
        return Image.file(mFile!, fit: BoxFit.cover);
      case "pdf":
        return Image.asset("assets/images/pdf.png", fit: BoxFit.contain);
      case "mp4":
        return Image.asset("assets/images/video.png", fit: BoxFit.contain);
      case "mp3":
        return Image.asset("assets/images/mp3.png", fit: BoxFit.contain);

      default:
        return Image.file(mFile!, width: 150, height: 150, fit: BoxFit.cover);
    }
  }

  Positioned _removeFileButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
        onTap: () => removePicked(),
        child: const CircleAvatar(
          radius: 15,
          backgroundColor: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Container _noFile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/upload.png",
            width: 100,
            height: 100,
          ),
          const Text(
            'Upload File',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
