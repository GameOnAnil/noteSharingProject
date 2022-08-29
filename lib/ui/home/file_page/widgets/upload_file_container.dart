// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class UploadFileContainer extends StatefulWidget {
  final File? mFile;
  final Function(File file, String name, String size) changeFile;
  final Function() removePicked;
  final String name;
  final String size;
  final Function onTap;

  const UploadFileContainer({
    Key? key,
    this.mFile,
    required this.changeFile,
    required this.removePicked,
    required this.name,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  State<UploadFileContainer> createState() => _UploadFileContainerState();
}

class _UploadFileContainerState extends State<UploadFileContainer> {
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onTap();
      },
      child: (widget.mFile == null) ? _noFile() : _hasFile(),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: purplePrimary),
              ),
              width: double.infinity,
              height: 200.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: Image.asset(
                          _getLogoUrl(),
                        )),
                    SizedBox(width: 10.w),
                    _buildRichText("Name: ", widget.name),
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
              color: purpleText,
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
    final fileType = widget.name.split('.')[1];
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
        onTap: () => widget.removePicked(),
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
