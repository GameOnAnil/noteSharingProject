// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/file_page_notifier.dart';
import 'package:note_sharing_project/ui/home/file_page/widgets/add_file_bottom_sheet.dart';
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
            // backgroundColor: purplePrimary,
            appBar: _appBar(ref, path, subject.notificationOn),
            floatingActionButton: _floatingActionButton(),
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
                                    .watch(filePageNotiferProvicer(path))
                                    .newFileList;
                                final isLoading = ref
                                    .watch(filePageNotiferProvicer(path))
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
      actions: [
        IconButton(
          onPressed: () async {
            ref.read(filePageNotiferProvicer(path)).enableSearch();
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: (isNotificationOn)
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
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                ref.read(filePageNotiferProvicer(path)).search(value);
              },
            ),
          ),
          SizedBox(height: 8.h),
        ],
      );
    });
  }

  Builder _floatingActionButton() {
    return Builder(builder: (context) {
      return FloatingActionButton(
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
                );
              });
        },
        child: const Icon(Icons.add),
        // label: SizedBox(
        //     width: MediaQuery.of(context).size.width * .5,
        //     child: const Center(
        //         child: Text(
        //       "Add Files",
        //     ))),
      );
    });
  }

  GridView _gridView(List<FileModel> fileList, int gridCount) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount, childAspectRatio: 1),
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
                      ref.read(filePageNotiferProvicer(path)).orderedBy("name");
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Sort By Size"),
                    onTap: () {
                      ref.read(filePageNotiferProvicer(path)).orderedBy("size");
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Sort By Date"),
                    onTap: () {
                      ref.read(filePageNotiferProvicer(path)).orderedBy("date");
                    },
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
