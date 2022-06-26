import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/services/storage_service.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class HorizontalFileTile extends StatelessWidget {
  const HorizontalFileTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FileModel item;
  Widget getLogo(String type, String url) {
    switch (type) {
      case "image/jpeg":
        return Image.network(
          url,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        );
      case "image/jpg":
        return Image.network(
          url,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        );
      case "image/png":
        return Image.network(
          url,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        );
      case "video/mp4":
        return Image.asset(
          "assets/images/video.png",
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          color: Colors.blue,
        );
      case "application/pdf":
        return Image.asset(
          "assets/images/pdf.png",
          width: 70,
          height: 70,
          fit: BoxFit.cover,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await StorageService().openFile(url: item.url, fileName: item.name);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              //  border: Border.all(color: Colors.black.withOpacity(.3)),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                getLogo(item.fileType, item.url),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: blueTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        item.size,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/menu.png",
                  width: 18,
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
