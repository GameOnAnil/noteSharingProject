import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/files_model.dart';

class CustomFileTile extends StatelessWidget {
  final FileModel fileModel;
  const CustomFileTile({
    Key? key,
    required this.fileModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    fileModel.name,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  _dateSizeRow(fileModel),
                  Divider(
                    height: 2,
                    color: Colors.black.withOpacity(.7),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _dateSizeRow(FileModel fileModel) {
    return Row(
      children: [
        Text(
          fileModel.date,
          style: TextStyle(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          fileModel.time,
          style: TextStyle(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Text(
          fileModel.size,
          style: TextStyle(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.w400,
              fontSize: 18),
        ),
      ],
    );
  }
}
