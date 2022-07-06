import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/ui/widgets/file_grid_tile.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: purplePrimary,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Files Page'),
        backgroundColor: purplePrimary,
      ),
      floatingActionButton: _floatingActionButton(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _sortingPart("Bese"),
              Expanded(child: _gridView(dummyFileList)),
            ],
          ),
        ),
      ),
    );
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
                  return _bottomSheet(context);
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

  Container _bottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Upload File",
              style: TextStyle(
                color: darkBlueBackground,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/upload.png",
                  color: purplePrimary,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            _editNameTextField(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
                  backgroundColor: MaterialStateProperty.all(purplePrimary),
                ),
                child: const Text(
                  "Upload",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _editNameTextField() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
            label: Text("Edit Name"),
            border: OutlineInputBorder(),
            suffix: Text("png")),
      ),
    );
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

  Widget _sortingPart(String path) {
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
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: const Text("Sort By Size"),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: const Text("Sort By Date"),
                    onTap: () {},
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
