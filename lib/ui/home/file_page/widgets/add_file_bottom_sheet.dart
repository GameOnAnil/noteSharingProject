import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/auth_provider.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/services/notification_service.dart';
import 'package:note_sharing_project/ui/home/file_page/widgets/upload_file_container.dart';
import 'package:note_sharing_project/utils/base_page.dart';
import 'package:note_sharing_project/utils/base_utils.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

import '../../../../utils/base_state.dart';

class AddFileBottomSheet extends BaseStatefulWidget {
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
  BaseState<AddFileBottomSheet> createState() => _AddFileBottomSheetState();
}

class _AddFileBottomSheetState extends BaseState<AddFileBottomSheet> {
  File? _file;
  String _name = "";
  String _size = "";
  late TextEditingController nameController;
  bool isLoading = false;
  late String path;

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
                  _uploadFile();
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

  _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      File? file = File(result.files.first.path!);
      String name = result.files.first.name;
      int byte = await file.length();
      final size = await getFileSize(byte, 2);

      _chageFile(file, name, size.toString());
    }
  }

  _handleUploadMobile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: true,
      );
      if (result != null) {
        Uint8List? file = result.files.first.bytes;
        String name = result.files.first.name;
        if (file == null) {
          throw "Failed to upload file.";
        }
        UploadTask task =
            FirebaseStorage.instance.ref().child("docs/$name").putData(file);
        setState(() => isLoading = true);

        final url = await task.snapshot.ref.getDownloadURL();
        final newModel = FileModel(
            name: name,
            date: getTodaysDate(),
            time: DateFormat('HH:mm:ss').format(DateTime.now()),
            size: await getFileSize(file.length, 2),
            filePath: "docs/$name",
            fileType: name.split(".")[1],
            url: url,
            uploaderId: ref.read(authProviderNotifier).userId ?? "");

        await FirebaseService().insertData(path, newModel);
        await _handleNotification(widget.subject.notificationOn);
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
    } catch (e) {
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
        final docRef = FirebaseStorage.instance.ref("docs/$_name");
        final task = await docRef.putFile(_file!);

        final url = await task.ref.getDownloadURL();
        final newModel = FileModel(
            name: nameController.text,
            date: getTodaysDate(),
            time: DateFormat('HH:mm:ss').format(DateTime.now()),
            size: _size,
            filePath: "docs/${nameController.text}",
            fileType: _name.split(".")[1],
            url: url,
            uploaderId: ref.read(authProviderNotifier).userId ?? "",
            documentId: '');

        await FirebaseService().insertData(path, newModel);
        await _handleNotification(widget.subject.notificationOn);
        setState(() => isLoading = false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully Added'),
          ),
        );
        Navigator.pop(context);
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
        setState(() => isLoading = false);
      }
    }
  }

  _handleNotification(bool notificationOn) async {
    await NotificationService().sendWithTagNotification(
        heading: "New Notes Added for $path",
        content: "New Notes Added Click to check it out.",
        tag: path);
  }

  Future<String> getFileSize(int raw, int decimals) async {
    if (raw <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(raw) / log(1024)).floor();
    return '${(raw / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
