import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/utils/my_colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../services/db_helper.dart';

class NotificationBellDialog extends StatefulWidget {
  final Subject subject;
  final Function() onChange;
  const NotificationBellDialog({
    Key? key,
    required this.subject,
    required this.onChange,
  }) : super(key: key);

  @override
  State<NotificationBellDialog> createState() =>
      _NotificationBellDialogState(notificationOn: subject.notificationOn);
}

class _NotificationBellDialogState extends State<NotificationBellDialog> {
  final bool notificationOn;
  bool isLoading = false;
  late String path;

  _NotificationBellDialogState({required this.notificationOn});

  @override
  void initState() {
    super.initState();
    path =
        "${widget.subject.program}-${widget.subject.semester}-${widget.subject.name}";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        visible: !isLoading,
        child: Text(
          (widget.subject.notificationOn)
              ? "Turn Off Notification"
              : "Turn On Notification",
          style: const TextStyle(
            color: bluePrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      content: (isLoading) ? _showProgressBar() : _contentText(),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        Visibility(
          visible: !isLoading,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Visibility(
          visible: !isLoading,
          child: TextButton(
            onPressed: () async {
              (notificationOn) ? _deleteTag() : _setTag();
            },
            child: const Text(
              "Confirm",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showProgressBar() => const SizedBox(
      height: 100, child: Center(child: CircularProgressIndicator()));

  Text _contentText() {
    return Text(
      (widget.subject.notificationOn)
          ? 'You will not receive any notification if new notes are added.'
          : "You will receive notification when any new notes are added.",
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }

  Future<void> _setTag() async {
    if (!mounted) {
      return;
    }
    setState(() => isLoading = true);
    final sendResponse = await OneSignal.shared.sendTag(path, path);
    if (sendResponse.containsKey(path)) {
      log("SUCCESS send tag response:$sendResponse");
    }
    final response = await DbHelper.instance.updateSubject(widget.subject
        .copyWith(notificationOn: !widget.subject.notificationOn));
    if (response == 1) {
      if (!mounted) {
        return;
      }
      Navigator.pop(context);
      widget.onChange();
    } else {
      setState(() => isLoading = false);
      log("response:$response");
    }
  }

  _deleteTag() async {
    setState(() => isLoading = true);
    final sendResponse = await OneSignal.shared.deleteTag(path);
    if (sendResponse.containsKey(path)) {
      log("SUCCESS deleted tag response:$sendResponse");
    }
    final response = await DbHelper.instance.updateSubject(widget.subject
        .copyWith(notificationOn: !widget.subject.notificationOn));

    if (response == 1) {
      if (!mounted) {
        return;
      }
      Navigator.pop(context);
      widget.onChange();
    } else {
      setState(() => isLoading = false);
      log("response:$response");
    }
  }
}
