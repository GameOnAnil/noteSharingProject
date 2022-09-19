import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:note_sharing_project/utils/base_utils.dart';
import 'package:path/path.dart';

import '../../../utils/base_page.dart';
import '../../../utils/base_state.dart';

class PDFViewerPage extends BaseStatefulWidget {
  final File file;

  const PDFViewerPage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  PDFViewerPageState createState() => PDFViewerPageState();
}

class PDFViewerPageState extends BaseState<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: _buildAppBar(text, context),
      body: PDFView(
        filePath: widget.file.path,
        autoSpacing: false,
        swipeHorizontal: true,
        pageSnap: true,
        onRender: (pages) {
          if (pages != null) {
            setState(() => this.pages = pages);
          }
        },
        onViewCreated: (controller) {
          setState(() => this.controller = controller);
        },
        onPageChanged: (indexPage, _) {
          if (indexPage != null) {
            setState(() => this.indexPage = indexPage);
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(String text, BuildContext context) {
    return AppBar(
      title: const Text("PDF"),
      actions: pages >= 2
          ? [
              Center(child: Text(text)),
              IconButton(
                icon: const Icon(Icons.chevron_left, size: 32),
                onPressed: () {
                  final page = indexPage == 0 ? pages : indexPage - 1;
                  controller.setPage(page);
                },
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 32),
                onPressed: () {
                  final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                  controller.setPage(page);
                },
              ),
              _buildDownloadButton(context)
            ]
          : [_buildDownloadButton(context)],
    );
  }

  IconButton _buildDownloadButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        showCustomAlertDialog(
          context,
          title: "Download",
          message: "Are you sure you want to download?",
          onPositiveTap: () async {
            Navigator.pop(context);
            showProgressDialog();
            final response = await downloadIntoInternal(widget.file);
            dismissProgressDialog();
            if (response != null) {
              Fluttertoast.showToast(msg: response);
            } else {
              Fluttertoast.showToast(msg: "File Downloaded");
            }
          },
          onNegativeTap: () {
            Navigator.pop(context);
          },
        );
      },
      icon: const FaIcon(Icons.download),
    );
  }

  Future<String?> downloadIntoInternal(File file) async {
    try {
      Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
      String? downloadsDirectoryPath = (downloadsDirectory)?.path;

      final name = basename(widget.file.path);
      if (downloadsDirectoryPath != null) {
        final storageFile = File("$downloadsDirectoryPath/$name");

        storageFile.writeAsBytes(await file.readAsBytes());
        return null;
      } else {
        return "Download Directory not found.";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
