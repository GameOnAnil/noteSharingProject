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
              color: lightBlueBackground,
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                          color: darkBlueBackground,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        item.date,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Posted By: Anil Thapa",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SizedBox(
                    width: 30,
                    height: double.infinity,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
