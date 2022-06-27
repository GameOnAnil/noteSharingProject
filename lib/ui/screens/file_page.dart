import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/ui/screens/add_file_page.dart';
import 'package:note_sharing_project/ui/widgets/file_grid_tile.dart';
import 'package:note_sharing_project/ui/widgets/horizontal_file_tile.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class FilePage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Center(child: Text("$semester $program")),
        elevation: 0,
        actions: [
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
          // FirebaseService().insertData("$program-$semester-$name");
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
                  const SizedBox(
                    height: 10,
                  ),
                  _sortingPart(),
                  Expanded(
                    child: StreamBuilder(
                        stream: FirebaseService()
                            .getFiles(path: "$program-$semester-$name"),
                        builder:
                            (context, AsyncSnapshot<List<FileModel>> snapshot) {
                          if (snapshot.data != null) {
                            final currentList = snapshot.data!;
                            //  return _gridView(currentList);
                            return _listView(currentList);
                          }
                          return Container();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GridView _gridView(List<FileModel> currentList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, childAspectRatio: .6),
      itemCount: currentList.length,
      itemBuilder: (context, index) {
        final item = currentList[index];
        return FileGridTile(item: item);
      },
    );
  }

  Widget _sortingPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text(
            "Files",
            style: TextStyle(
              color: darkBlueBackground,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          Expanded(child: SizedBox()),
          Icon(
            Icons.sort,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Name",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
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
