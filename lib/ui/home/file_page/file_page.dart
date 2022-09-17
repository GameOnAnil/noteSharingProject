import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/file_page_notifier.dart';
import 'package:note_sharing_project/providers/recent_file_notifier.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/services/shared_pref_service.dart';
import 'package:note_sharing_project/ui/home/file_page/widgets/add_file_bottom_sheet.dart';
import 'package:note_sharing_project/ui/home/file_page/widgets/file_grid_tile.dart';
import 'package:note_sharing_project/utils/base_page.dart';
import 'package:note_sharing_project/utils/base_state.dart';
import 'package:note_sharing_project/utils/base_utils.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

import '../../../providers/auth_provider.dart';

class FilePage extends BaseStatefulWidget {
  final Subject subject;
  final int gridCount;
  const FilePage({
    Key? key,
    required this.gridCount,
    required this.subject,
  }) : super(key: key);

  @override
  BaseState<FilePage> createState() => _FilePageState();
}

class _FilePageState extends BaseState<FilePage> {
  late String path;
  @override
  void initState() {
    path =
        "${widget.subject.program}-${widget.subject.semester}-${widget.subject.name}";
    ref.read(filePageNotifierProvider(path)).initSubject(widget.subject);

    SharedPrefService().setRecentSubject(widget.subject);
    ref.read(recentFileNotifierProvider).getRecentFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSearchVisible =
        ref.watch(filePageNotifierProvider(path)).isSearchVisible;

    final notifitionOn =
        ref.watch(filePageNotifierProvider(path)).subject?.notificationOn;

    final sub = ref.watch(filePageNotifierProvider(path)).subject;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: purplePrimary,
      appBar: _appBar(ref, path, notifitionOn),
      floatingActionButton: (sub != null) ? _floatingActionButton(sub) : null,
      body: Column(
        children: [
          isSearchVisible ? _searchBar(path) : const SizedBox(),
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
                            return _gridView(fileList, widget.gridCount);
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
    );
  }

  Future<String> getFileSize(int raw, int decimals) async {
    if (raw <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(raw) / log(1024)).floor();
    return '${(raw / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  Column _listEmpty() {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Lottie.asset("assets/animations/empty_list.json"),
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

  AppBar _appBar(WidgetRef ref, String path, bool? notifitionOn) {
    return AppBar(
      elevation: 0.0,
      title: const Text('Files Page'),
      backgroundColor: purplePrimary,
      actions: [
        IconButton(
          onPressed: () async {
            ref.read(filePageNotifierProvider(path)).enableSearch();
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () async {
            showCustomAlertDialog(
              context,
              title: (notifitionOn ?? true)
                  ? "Turn Notification Off"
                  : "Turn Notification On",
              message: (notifitionOn ?? true)
                  ? "Are you sure you want to turn off notification?"
                  : "Are you sure you want to turn on Notification?",
              positiveButtonText: "Confirm",
              negativeButtonText: "Cancel",
              onNegativeTap: () {
                Navigator.pop(context);
              },
              onPositiveTap: () async {
                await ref
                    .read(filePageNotifierProvider(path))
                    .setNotification();
                await ref
                    .read(filePageNotifierProvider(path))
                    .getNewSubject(name: widget.subject.name);
                if (mounted) Navigator.pop(context);
              },
            );
          },
          icon: (notifitionOn ?? false)
              ? const FaIcon(FontAwesomeIcons.bell)
              : const Icon(Icons.notifications_off),
        )
      ],
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
                label: const Text("Search By"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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

  _handleUploadWeb() async {
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
        showProgressDialog();

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
        widget.dismissProgressDialog();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully Added'),
          ),
        );
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ERROR:$e'),
        ),
      );
      widget.dismissProgressDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ERROR:$e'),
        ),
      );
      widget.dismissProgressDialog();
    }
  }

  Builder _floatingActionButton(Subject subject) {
    return Builder(builder: (context) {
      return FloatingActionButton.extended(
        elevation: 8,
        backgroundColor: purplePrimary,
        onPressed: () async {
          if (Platform.isAndroid || Platform.isIOS) {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return AddFileBottomSheet(
                    semester: subject.semester,
                    program: subject.program,
                    name: subject.name,
                    subject: subject,
                  );
                });
          } else {
            _handleUploadWeb();
          }
        },
        label: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: const Center(
            child: Text(
              "Add Files",
            ),
          ),
        ),
      );
    });
  }

  GridView _gridView(List<FileModel> fileList, int gridCount) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount, childAspectRatio: .80),
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          return FileGridTile(
            path: path,
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
