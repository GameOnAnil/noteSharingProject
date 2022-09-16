import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/utils/custom_alert_dialog.dart';

import 'custom_alert_dialog2.dart';

String getPathFromSubject(Subject subject) {
  return "${subject.program}-${subject.semester}-${subject.name}";
}

String getTodaysDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  return formattedDate;
}

showCustomAlertDialog(
  BuildContext context, {
  String? title,
  String? message,
  Widget? child,
  String? positiveButtonText,
  String? negativeButtonText,
  required Function onPositiveTap,
  required Function onNegativeTap,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: title,
          message: message,
          positiveButtonText: positiveButtonText,
          negativeButtonText: negativeButtonText,
          onPositiveTap: () => onPositiveTap(),
          onNegativeTap: () => onNegativeTap(),
          child: child,
        );
      });
}

showCustomAlertDialog2(BuildContext context,
    {String? title,
    String? message,
    Widget? child,
    String? btnText,
    required Function() onTap}) {
  return showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog2(
          title: title,
          message: message,
          buttonText: btnText,
          onTap: () => onTap(),
          child: child,
        );
      });
}
