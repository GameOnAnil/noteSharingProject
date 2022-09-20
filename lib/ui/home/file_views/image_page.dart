import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/base_utils.dart';
import '../../../utils/basestateless_widget.dart';

class ImagePage extends BaseStatelessWidget {
  final File file;
  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        actions: [
          _buildDownloadButton(context),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Image.file(
            file,
            fit: BoxFit.contain,
          ),
        ),
      ),
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
            showProgressDialog(context);
            final response = await downloadIntoInternal(file);
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
}
