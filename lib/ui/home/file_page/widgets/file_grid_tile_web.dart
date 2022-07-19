import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/providers/file_grid_notifer.dart';
import 'package:note_sharing_project/utils/my_colors.dart';
import "package:universal_html/html.dart" as html;

class FileGridTileWeb extends ConsumerWidget {
  final FileModel fileModel;
  const FileGridTileWeb({
    Key? key,
    required this.fileModel,
  }) : super(key: key);

  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress =
        ref.watch(fileGridNotifierProvider(fileModel.name)).progress;

    return GestureDetector(
      onTap: () async {
        // if (!await launchUrl(Uri.parse(fileModel.url))) {
        //   throw 'Could not launch ${fileModel.url}}';
        // }
        // Dio().download(, savePath)
        downloadFile("assets/images/bg.jpeg");
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.star_outline),
                _popUpButton(),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getLogo(fileModel.fileType),
                  _nameText(),
                ],
              ),
            ),
            Column(
              children: [
                (progress != 0) ? _progressIndicator(progress) : _divider(),
                _bottomPart(),
              ],
            ),
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

  Padding _popUpButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: SizedBox(
        width: 30.w,
        height: 30.h,
        child: PopupMenuButton(
          onSelected: (value) {},
          itemBuilder: (context) => [
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.report, color: Colors.red),
                title: Text("Report"),
              ),
            ),
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
        ),
      ),
    );
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
        fileModel.name,
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
          _fileSize(),
          _userProfile(),
        ],
      ),
    );
  }

  Container _userProfile() {
    return Container(
      width: 30.w,
      height: 30.h,
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
          fileModel.size,
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
    return Center(
      child: Container(
        width: 70,
        height: 70,
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
      ),
    );
  }
}
