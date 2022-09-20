import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_sharing_project/models/report_file_model.dart';
import 'package:note_sharing_project/ui/admin/admin_description_page/widgets/text_row.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

import '../../../services/firebase_service.dart';
import '../../../services/pdf_service.dart';
import '../../../services/storage_service.dart';
import '../../../utils/basestateless_widget.dart';
import '../../home/file_views/image_page.dart';
import '../../home/file_views/pdf_page.dart';
import '../../home/file_views/video_page.dart';

class AdminDescriptionPage extends BaseStatelessWidget {
  final ReportFileModel reportedFile;
  const AdminDescriptionPage({
    Key? key,
    required this.reportedFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("File Description"),
      ),
      bottomNavigationBar: _buildButtonRow(context),
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: _buildContent(),
          )
        ],
      ),
    );
  }

  Column _buildContent() {
    return Column(
      children: [
        TextRow(
          title: "File Name: ",
          description: reportedFile.name,
        ),
        TextRow(
          title: "File Size: ",
          description: reportedFile.size,
        ),
        TextRow(
          title: "Reported Description: ",
          description: reportedFile.report,
        ),
        TextRow(
          title: "Reporter Name: ",
          description: reportedFile.reporterName,
        ),
        TextRow(
          title: "Reporter Email: ",
          description: reportedFile.reporterEmail,
        ),
      ],
    );
  }

  Container _header(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            child: Center(
              child: _getLogo(reportedFile.fileType),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final type = reportedFile.fileType;
              final url = reportedFile.url;
              final name = reportedFile.name;
              if (type == "pdf") {
                await _openPdfFile(context, url, name);
              } else if (type == "png" || type == "jpg" || type == "jpeg") {
                await _openImage(context, url, name);
              } else if (type == "mp4") {
                await _openVideo(context, url, name);
              } else {
                Fluttertoast.showToast(msg: "File Not Supported");
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r))),
              backgroundColor: MaterialStateProperty.all(purplePrimary),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.h),
              child: const Text(
                "Open File",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  _getLogo(String type) {
    return Container(
      width: double.infinity,
      height: 250.h,
      decoration: const BoxDecoration(
        color: lightPurpleBackground,
      ),
      child: Center(
          child: Image.asset(
        getLogoUrl(type),
        width: 110.w,
        height: 100.h,
      )),
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

  _buildButtonRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      height: 56.h,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                height: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green.withOpacity(.8)),
                  ),
                  onPressed: () async {
                    await _handleApprove(context, reportedFile);
                  },
                  child: const Text("Approve"),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                height: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red.withOpacity(.8)),
                  ),
                  onPressed: () async {
                    await _handleDelete(context, reportedFile);
                  },
                  child: const Text("Delete"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _handleApprove(BuildContext context, ReportFileModel fileModel) async {
    showProgressDialog(context);
    await FirebaseService().deleteReportedFileOnly(fileModel);
    dismissProgressDialog();
    Navigator.pop(context);
  }

  _handleDelete(BuildContext context, ReportFileModel fileModel) async {
    showProgressDialog(context);
    await FirebaseService().deleteAllReportedFile(fileModel);
    dismissProgressDialog();
    Navigator.pop(context);
  }

  Future<void> _openPdfFile(
      BuildContext context, String url, String fileName) async {
    try {
      showProgressDialog(context);
      final file = await PDFService.loadNetwork(url, fileName);
      dismissProgressDialog();

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
    } catch (e) {
      dismissProgressDialog();
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _openImage(
      BuildContext context, String url, String fileName) async {
    try {
      showProgressDialog(context);
      final file = await StorageService.loadNetwork(url, fileName);
      dismissProgressDialog();

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ImagePage(file: file)),
      );
    } catch (e) {
      dismissProgressDialog();
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _openVideo(
      BuildContext context, String url, String fileName) async {
    try {
      showProgressDialog(context);
      final file = await StorageService.loadNetwork(url, fileName);
      dismissProgressDialog();

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => VideoPage(file: file)),
      );
    } catch (e) {
      dismissProgressDialog();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
