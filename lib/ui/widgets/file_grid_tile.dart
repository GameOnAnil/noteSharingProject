import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/files_model.dart';

class FileGridTile extends StatelessWidget {
  const FileGridTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FileModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // final downloadUrl =
        //     await FirebaseStorage.instance.ref(item.filePath).getDownloadURL();
        //await StorageService().openFile(url: item.url, fileName: item.name);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getLogo(item.fileType, item.url),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLogo(String type, String url) {
    switch (type) {
      case "image/jpeg":
        return Image.network(
          url,
          width: 60,
          height: 80,
          fit: BoxFit.cover,
        );
      case "image/jpg":
        return Image.network(
          url,
          width: 50,
          height: 60,
          fit: BoxFit.cover,
        );
      case "image/png":
        return Image.network(
          url,
          width: 50,
          height: 60,
          fit: BoxFit.cover,
        );
      case "video/mp4":
        return Image.asset("assets/images/mp4.png");
      default:
        return Image.asset("assets/images/folder.png");
    }
  }
}
