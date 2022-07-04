import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/providers/file_grid_notifer.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class FileGridTile extends ConsumerWidget {
  final FileModel fileModel;
  const FileGridTile({
    Key? key,
    required this.fileModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress =
        ref.watch(fileGridNotifierProvider(fileModel.name)).progress;

    return GestureDetector(
      onTap: () async {
        await ref
            .read(fileGridNotifierProvider(fileModel.name))
            .openFile(url: fileModel.url, fileName: fileModel.name);
      },
      child: Container(
        width: 200,
        height: 300,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // border: Border.all(color: Colors.grey.withOpacity(.5)),
            color: creamColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: .25,
                blurRadius: 5,
                offset: const Offset(5, 5),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.star_outline),
                _popUpButton(),
              ],
            ),
            _fileLogo(fileModel.fileType),
            Expanded(child: _nameText()),
            _divider(),
            _bottomPart(),
            Visibility(
              visible: (progress != 0) ? true : false,
              child: LinearProgressIndicator(
                value: progress / 100,
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _popUpButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: SizedBox(
        width: 30,
        height: 30,
        child: PopupMenuButton(
          onSelected: (value) {},
          itemBuilder: (context) => [
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(
                  Icons.report,
                  color: Colors.red,
                ),
                title: Text("Report"),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(
                  Icons.download,
                  color: Color.fromARGB(255, 37, 68, 38),
                ),
                title: Text("Download"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fileLogo(String type) {
    return Container(
      width: 85,
      height: 85,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
        "assets/images/folder border.png",
      ))),
      child: Center(
        child: Text(
          type,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Padding _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
        height: 2,
        color: Colors.black,
      ),
    );
  }

  Padding _nameText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Text(
        fileModel.name,
        style: const TextStyle(
          color: blueTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding _bottomPart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _fileSize(),
          _userProfile(),
        ],
      ),
    );
  }

  Container _userProfile() {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.deepOrange),
      child: const Center(
        child: Text(
          'A',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Column _fileSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "File Size:",
          style: TextStyle(
            color: bluePrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          fileModel.size,
          style: const TextStyle(
            color: bluePrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget getLogo(String type, String url) {
    switch (type) {
      case "jpeg":
        return Image.network(
          url,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        );
      case "jpg":
        return Image.network(
          url,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        );
      case "png":
        return Image.network(
          url,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        );
      case "mp4":
        return Image.asset(
          "assets/images/video.png",
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          color: Colors.blue,
        );
      case "pdf":
        return Container(
          width: 90,
          height: 50,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/folderblue.png"))),
          child: const Center(
            child: Text(
              'PDF',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        );
      default:
        return Image.asset(
          "assets/images/folder3.png",
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          color: Colors.blue,
        );
    }
  }
}
