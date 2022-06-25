import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/ui/widgets/custom_file_tile.dart';
import 'package:note_sharing_project/ui/widgets/filegrid_tile.dart';

import '../widgets/right_triangle_widget.dart';

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
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          IconButton(
            onPressed: () {
              FirebaseService().insertData("$program-$semester-$name");
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _header(),
            _sortingPart(),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseService()
                        .getFiles(path: "$program-$semester-$name"),
                    builder:
                        (context, AsyncSnapshot<List<FileModel>> snapshot) {
                      if (snapshot.data != null) {
                        final currentList = snapshot.data!;
                        return _gridView(currentList);
                        // return _listView(currentList);
                      }
                      return Container();
                    })),
          ],
        ),
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
        });
  }

  ListView _listView(List<FileModel> currentList) {
    return ListView.builder(
      itemCount: currentList.length,
      itemBuilder: ((context, index) {
        return CustomFileTile(
          fileModel: currentList[index],
        );
      }),
    );
  }

  Row _sortingPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
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
        SizedBox(
          width: 10,
        ),
        Icon(Icons.arrow_upward)
      ],
    );
  }

  Padding _header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            "assets/images/folderHome.png",
            width: 30,
            height: 30,
            color: Colors.black.withOpacity(.7),
          ),
          const SizedBox(
            width: 10,
          ),
          const RightTriangleWidget(),
          const SizedBox(
            width: 5,
          ),
          Text(
            "4th Sem",
            style: TextStyle(
                color: Colors.black.withOpacity(.6),
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          const SizedBox(
            width: 4,
          ),
          const RightTriangleWidget(),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "WT",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const Expanded(child: SizedBox()),
          const Icon(
            Icons.star_outline,
            size: 25,
          )
        ],
      ),
    );
  }
}
