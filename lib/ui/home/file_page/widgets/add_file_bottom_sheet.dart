import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/services/notification_service.dart';
import 'package:note_sharing_project/ui/home/file_page/widgets/upload_file_container.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class AddFileBottomSheet extends StatefulWidget {
  final String name;
  final String semester;
  final String program;
  final Subject subject;
  const AddFileBottomSheet({
    Key? key,
    required this.name,
    required this.semester,
    required this.program,
    required this.subject,
  }) : super(key: key);

  @override
  State<AddFileBottomSheet> createState() => _AddFileBottomSheetState();
}

class _AddFileBottomSheetState extends State<AddFileBottomSheet> {
  File? _file;
  String _name = "";
  String _size = "";
  late TextEditingController nameController;
  bool isLoading = false;
  late String path;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    path = "${widget.program}-${widget.semester}-${widget.name}";
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r), color: Colors.white),
      child: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _body(),
    );
  }

  Padding _body() {
    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              progress.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10.h),
            Text(
              "Upload File",
              style: TextStyle(
                color: purpleText,
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(height: 10.h),
            UploadFileContainer(
                onTap: () async {
                  await _handleUploadWeb();
                },
                changeFile: ((file, name, size) {
                  _chageFile(file, name, size);
                }),
                mFile: _file,
                removePicked: () {
                  setState(() => _file = null);
                },
                name: _name,
                size: _size),
            _editNameTextField(),
            SizedBox(
              width: double.infinity,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () async {
                  await handleUpload();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r))),
                  backgroundColor: MaterialStateProperty.all(purplePrimary),
                ),
                child: Text(
                  "Upload",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleUploadWeb() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result != null) {
        Uint8List? file = result.files.first.bytes;
        String name = result.files.first.name;
        UploadTask task =
            FirebaseStorage.instance.ref().child("docs/$name").putData(file!);
        setState(() => isLoading = true);

        final url = await task.snapshot.ref.getDownloadURL();
        final newModel = FileModel(
            name: name,
            date: "2022-01-01",
            time: "02 00 Pm",
            size: _size,
            filePath: "docs/$name",
            fileType: name.split(".")[1],
            url: url);

        await FirebaseService().insertData(path, newModel);
        setState(() => isLoading = false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully Added'),
          ),
        );
        Navigator.pop(context);
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ERROR:$e'),
        ),
      );
      Navigator.pop(context);
    }
  }

  Padding _editNameTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h),
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          label: const Text("Edit Name"),
          border: const OutlineInputBorder(),
          suffix: (_name.isNotEmpty) ? Text(".${_name.split(".")[1]}") : null,
        ),
      ),
    );
  }

  void _chageFile(File file, String name, String size) {
    setState(() {
      _file = file;
      _name = name;
      _size = size;
      nameController.text = _name.split(".")[0];
    });
  }

  Future<void> handleUpload() async {
    if (_file == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Add File'),
        ),
      );
    } else if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter Name'),
        ),
      );
    } else {
      try {
        setState(() => isLoading = true);
        final ref = FirebaseStorage.instance.ref("docs/$_name");
        final task = ref.putFile(_file!);

        final url = await task.snapshot.ref.getDownloadURL();
        final newModel = FileModel(
            name: nameController.text,
            date: "2022-01-01",
            time: "02 00 Pm",
            size: _size,
            filePath: "docs/${nameController.text}",
            fileType: _name.split(".")[1],
            url: url);

        await FirebaseService().insertData(path, newModel);
        await handleNotification(widget.subject.notificationOn);
        setState(() => isLoading = false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully Added'),
          ),
        );
        Navigator.pop(context);
      } on FirebaseException catch (e) {
        log("firebase exception:$e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
        setState(() => isLoading = false);
      }
    }
  }

  handleNotification(bool notificationOn) async {
    log("send noti:$notificationOn");
    if (notificationOn) {
      await NotificationService().sendWithTagNotification(
          heading: "New Notes Added for $path",
          content: "New Notes Added Click to check it out.",
          tag: path);
    }
  }
}
