import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/ui/screens/open_file_page.dart';

class FileGridTile extends StatelessWidget {
  const FileGridTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FileModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => OpenFilePage(
                filePath: item.filePath,
              )),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            item.fileType == "image"
                ? Image.asset(
                    "assets/images/pdf.png",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/pdf.png",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
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
}
