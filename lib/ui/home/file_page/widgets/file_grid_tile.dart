import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/providers/file_grid_notifer.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/utils/base_page.dart';
import 'package:note_sharing_project/utils/base_utils.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

import '../../../../utils/base_state.dart';

class FileGridTile extends BaseStatefulWidget {
  final FileModel fileModel;
  final String path;
  const FileGridTile({
    Key? key,
    required this.path,
    required this.fileModel,
  }) : super(key: key);

  @override
  BaseState<FileGridTile> createState() => _FileGridTileState();
}

class _FileGridTileState extends BaseState<FileGridTile> {
  @override
  Widget build(BuildContext context) {
    final progress =
        ref.watch(fileGridNotifierProvider(widget.fileModel.name)).progress;

    return GestureDetector(
      onTap: () async {
        ref.read(fileGridNotifierProvider(widget.fileModel.name)).openFile(
            url: widget.fileModel.url, fileName: widget.fileModel.name);
      },
      child: Container(
        width: 200.w,
        height: 300.h,
        margin: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: .25,
                blurRadius: 5,
                offset: Offset(5.w, 5.h),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.star_outline),
                _popUpButton(context),
              ],
            ),
            _getLogo(widget.fileModel.fileType),
            Expanded(child: _nameText()),
            (progress != 0) ? _progressIndicator(progress) : _divider(),
            _bottomPart(),
          ],
        ),
      ),
    );
  }

  LinearProgressIndicator _progressIndicator(double progress) {
    return LinearProgressIndicator(
      minHeight: 5.h,
      value: progress / 100,
    );
  }

  Padding _popUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: SizedBox(
        width: 30.w,
        height: 30.h,
        child: PopupMenuButton(
          onSelected: (value) {},
          itemBuilder: (context) => [
            PopupMenuItem(
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(
                        Icons.download,
                        color: Color.fromARGB(255, 37, 68, 38),
                      ),
                      title: Text("Download"),
                    ),
                  ),
                ],
                child: ListTile(
                  onTap: () async {
                    showCustomAlertDialog2(
                      context,
                      title: "Choose Report Type",
                      btnText: "Dismiss",
                      child: _buildReportListView(context),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                  leading: const Icon(Icons.report, color: Colors.red),
                  title: const Text("Report"),
                ),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(
                style: ListTileStyle.drawer,
                leading: Icon(
                  Icons.download,
                  color: Color.fromARGB(255, 37, 68, 38),
                ),
                title: Text("Download"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildReportListView(BuildContext context) {
    final reportTypeList = [
      "Inappropriate File",
      "Corrupt File",
      "Wrong subject",
    ];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: reportTypeList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            await _handleReportFile(context, reportTypeList[index]);
          },
          child: Column(
            children: [
              Text(
                reportTypeList[index],
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleReportFile(BuildContext context, String message) async {
    showProgressDialog();
    if (mounted) Navigator.pop(context);
    await FirebaseService().insertReportFile(
      widget.path,
      widget.fileModel,
      message,
    );
    dismissProgressDialog();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File Reported Successfully'),
        ),
      );
    }
  }

  Padding _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Divider(height: 2.h, color: Colors.black),
    );
  }

  Padding _nameText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 4.h),
      child: Text(
        widget.fileModel.name,
        style: TextStyle(
          color: purpleText,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding _bottomPart() {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _fileSize()),
          _userProfile(),
        ],
      ),
    );
  }

  _userProfile() {
    return SizedBox(
      width: 30.w,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), color: purplePrimary),
          child: Center(
            child: Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _fileSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "File Size:",
          style: TextStyle(
            color: bluePrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        Text(
          widget.fileModel.size,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: bluePrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  String getLogoUrl(String type) {
    switch (type) {
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

  _getLogo(String type) {
    return Container(
      width: 90.w,
      height: 90.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: lightPurpleBackground,
      ),
      child: Center(
          child: Image.asset(
        getLogoUrl(type),
        width: 40.w,
        height: 40.h,
      )),
    );
  }
}
