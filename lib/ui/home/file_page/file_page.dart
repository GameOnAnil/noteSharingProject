import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/file_page_notifier.dart';
import 'package:note_sharing_project/services/shared_pref_service.dart';
import 'package:note_sharing_project/ui/home/file_page/widgets/add_file_bottom_sheet.dart';
import 'package:note_sharing_project/ui/home/file_page/widgets/file_grid_tile.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class FilePage extends ConsumerStatefulWidget {
  final Subject subject;
  final int gridCount;
  const FilePage({
    Key? key,
    required this.gridCount,
    required this.subject,
  }) : super(key: key);

  @override
  ConsumerState<FilePage> createState() => _FilePageState();
}

class _FilePageState extends ConsumerState<FilePage> {
  late String path;
  @override
  void initState() {
    path =
        "${widget.subject.program}-${widget.subject.semester}-${widget.subject.name}";
    ref.read(filePageNotifierProvider(path)).initSubject(widget.subject);

    SharedPrefService().setRecentSubject(widget.subject);
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
            await ref.read(filePageNotifierProvider(path)).setNotification();
            await ref
                .read(filePageNotifierProvider(path))
                .getNewSubject(name: widget.subject.name);
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

  Builder _floatingActionButton(Subject subject) {
    return Builder(builder: (context) {
      return FloatingActionButton.extended(
          elevation: 8,
          backgroundColor: purplePrimary,
          onPressed: () {
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
          },
          label: SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: const Center(
                  child: Text(
                "Add Files",
              ))));
    });
  }

  GridView _gridView(List<FileModel> fileList, int gridCount) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount, childAspectRatio: .85),
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
