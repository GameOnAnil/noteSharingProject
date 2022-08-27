// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/file_page_notifier.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/ui/home/file_page/widgets/file_grid_tile_web.dart';
import 'package:note_sharing_project/ui/home/widgets/navigation_drawer.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class FilePageWeb extends ConsumerWidget {
  final Subject subject;
  final int gridCount;

  const FilePageWeb({
    Key? key,
    required this.subject,
    required this.gridCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String path = "${subject.program}-${subject.semester}-${subject.name}";

    return Row(
      children: [
        const NavigationDrawer(),
        Expanded(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            appBar: _appBar(ref, path, subject.notificationOn),
            floatingActionButton: _floatingActionButton(path),
            body: Column(
              children: [
                _searchBar(path),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.r),
                        topLeft: Radius.circular(30.r),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Column(
                        children: [
                          _sortingPart(path, ref),
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final fileList = ref
                                    .watch(filePageNotifierProvider(path))
                                    .newFileList;
                                final isLoading = ref
                                    .watch(filePageNotifierProvider(path))
                                    .isLoading;
                                if (isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (fileList.isEmpty) {
                                  return _listEmpty();
                                } else {
                                  //return _listView(fileList);
                                  return _gridView(fileList, gridCount);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _listEmpty() {
    return Column(
      children: [
        SizedBox(height: 40.h),
        ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: 200, maxHeight: 400, minHeight: 300, maxWidth: 600),
          child: Lottie.asset("assets/animations/empty_list.json"),
        ),
        Text(
          'No Files Found.',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 24.sp,
          ),
        ),
      ],
    );
  }

  AppBar _appBar(WidgetRef ref, String path, bool isNotificationOn) {
    return AppBar(
      elevation: 0.0,
      title: const Text('Files Page'),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    );
  }

  Consumer _searchBar(String path) {
    return Consumer(builder: (context, ref, child) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                label: const Text("Search Notes"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                ref.read(filePageNotifierProvider(path)).search(value);
              },
            ),
          ),
          SizedBox(height: 8.h),
        ],
      );
    });
  }

  Builder _floatingActionButton(String path) {
    return Builder(builder: (context) {
      return FloatingActionButton(
        elevation: 8,
        backgroundColor: purplePrimary,
        onPressed: () {
          _handleUploadWeb(context, path);
        },
        child: const Icon(Icons.add),
      );
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<String> getFileSize(int raw, int decimals) async {
    if (raw <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(raw) / log(1024)).floor();
    return '${(raw / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  _handleUploadWeb(BuildContext context, String path) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result != null) {
        Uint8List? file = result.files.first.bytes;
        String name = result.files.first.name;
        UploadTask task =
            FirebaseStorage.instance.ref().child("docs/$name").putData(file!);

        showLoaderDialog(context);
        final url = await task.snapshot.ref.getDownloadURL();
        final date = DateTime.now();
        final size = await getFileSize(file.length, 2);
        final newModel = FileModel(
            name: name,
            date: date.toString(),
            time: "02 00 Pm",
            size: size,
            filePath: "docs/$name",
            fileType: name.split(".")[1],
            url: url);

        await FirebaseService().insertData(path, newModel);

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

  GridView _gridView(List<FileModel> fileList, int gridCount) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount,
            childAspectRatio: 1,
            crossAxisSpacing: 2),
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          return FileGridTileWeb(
            fileModel: fileList[index],
          );
        });
  }

  Widget _sortingPart(String path, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Files",
            style: TextStyle(
              color: purpleText,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          const Expanded(child: SizedBox()),
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: ((context) => [
                  PopupMenuItem(
                    child: const Text("Sort By Name"),
                    onTap: () {
                      ref
                          .read(filePageNotifierProvider(path))
                          .orderedBy("name");
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Sort By Size"),
                    onTap: () {
                      ref
                          .read(filePageNotifierProvider(path))
                          .orderedBy("size");
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Sort By Date"),
                    onTap: () {
                      ref
                          .read(filePageNotifierProvider(path))
                          .orderedBy("date");
                    },
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
