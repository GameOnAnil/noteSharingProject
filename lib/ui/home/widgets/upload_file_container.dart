import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.only(right: 15.0.w, top: 10.h),
            child: Container(
              height: 250.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: purplePrimary),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: Image.asset(
                          _getLogoUrl(),
                        )),
                    SizedBox(width: 10.w),
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
            style: TextStyle(
              color: darkBlueBackground,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  String _getLogoUrl() {
    final fileType = name.split('.')[1];
    switch (fileType) {
      case "jpeg":
        return "assets/images/picture.png";
      case "jpg":
        return "assets/images/picture.png";
      case "png":
        return "assets/images/picture.png";
      case "mp4":
        return "assets/images/mp4.png";
      case "pdf":
        return "assets/images/pdf.png";
      default:
        return "assets/images/picture.png";
    }
  }

  Positioned _removeFileButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
        onTap: () => removePicked(),
        child: CircleAvatar(
          radius: 15.r,
          backgroundColor: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 20.r,
          ),
        ),
      ),
    );
  }

  Container _noFile() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/upload.png",
            width: 100.w,
            height: 100.h,
            color: purplePrimary,
          ),
          Text(
            'Upload File',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
