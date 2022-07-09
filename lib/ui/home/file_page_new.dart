import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/file_page_notifier.dart';
import 'package:note_sharing_project/ui/widgets/add_file_bottom_sheet.dart';
import 'package:note_sharing_project/ui/widgets/file_grid_tile.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class FilePageNew extends ConsumerWidget {
  final Subject subject;
  const FilePageNew({
    required this.subject,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String path = "${subject.program}-${subject.semester}-${subject.name}";
    final isSearchVisible =
        ref.watch(filePageNotiferProvicer(path)).isSearchVisible;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: purplePrimary,
      appBar: _appBar(ref, path, subject.notificationOn),
      floatingActionButton: _floatingActionButton(),
      body: Column(
        children: [
          isSearchVisible ? _searchBar(path) : const SizedBox(),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                            return _gridView(fileList);
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

  Column _listEmpty() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Lottie.asset("assets/animations/empty_list.json"),
        const Text(
          'No Files Found.',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  AppBar _appBar(WidgetRef ref, String path, bool isNotificationOn) {
    return AppBar(
      elevation: 0.0,
      title: const Text('Files Page'),
      backgroundColor: purplePrimary,
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
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                label: const Text("Search By"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                ref.read(filePageNotiferProvicer(path)).search(value);
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  Builder _floatingActionButton() {
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

  GridView _gridView(List<FileModel> fileList) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: .85),
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          return FileGridTile(
            fileModel: fileList[index],
          );
        });
  }

  Widget _sortingPart(String path, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Files",
            style: TextStyle(
              color: darkBlueBackground,
              fontWeight: FontWeight.w700,
              fontSize: 20,
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
