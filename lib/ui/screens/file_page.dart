import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/providers/file_page_notifier.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/ui/screens/add_file_page.dart';
import 'package:note_sharing_project/ui/widgets/horizontal_file_tile.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class FilePage extends ConsumerWidget {
  final String name;
  final String semester;
  final String program;
  const FilePage(
      {Key? key,
      required this.name,
      required this.semester,
      required this.program})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchVisible = ref.watch(filePageNotiferProvicer).isSearchVisible;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Center(child: Text("$semester $program")),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(filePageNotiferProvicer).enableSearch();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseService()
                  .insertDummyData("$program-$semester-$name");
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => AddFilePage(
                    name: name,
                    program: program,
                    semester: semester,
                  )),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          isSearchVisible ? _searchBar() : const SizedBox(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _sortingPart(ref),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final fileList =
                            ref.watch(filePageNotiferProvicer).newFileList;

                        if (fileList.isEmpty) {
                          return const Center(
                            child: Text("List empty"),
                          );
                        } else {
                          return _listView(fileList);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Consumer _searchBar() {
    return Consumer(builder: (context, ref, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text("Search By"),
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                ref.read(filePageNotiferProvicer).search(value);
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  Widget _sortingPart(WidgetRef ref) {
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
                      ref.read(filePageNotiferProvicer).orderedBy("name");
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Sort By Size"),
                    onTap: () {
                      ref.read(filePageNotiferProvicer).orderedBy("size");
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Sort By Date"),
                    onTap: () {
                      ref.read(filePageNotiferProvicer).orderedBy("date");
                    },
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _listView(List<FileModel> currentList) {
    return ListView.builder(
      itemCount: currentList.length,
      itemBuilder: ((context, index) {
        final item = currentList[index];
        return HorizontalFileTile(item: item);
      }),
    );
  }
}
