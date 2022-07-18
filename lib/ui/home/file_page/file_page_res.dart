// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/ui/home/file_page/file_page.dart';
import 'package:note_sharing_project/ui/home/file_page/file_page_web.dart';

class FilePageBuilder extends StatelessWidget {
  final Subject subject;
  const FilePageBuilder({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth > 1000) {
          return FilePageWeb(
            subject: subject,
            gridCount: 4,
          );
        } else if (constraints.maxWidth > 600 && constraints.maxWidth < 1000) {
          return FilePageWeb(
            subject: subject,
            gridCount: 3,
          );
        } else {
          return FilePage(subject: subject);
        }
      }),
    );
  }
}
