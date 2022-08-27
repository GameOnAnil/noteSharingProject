// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:note_sharing_project/ui/home/semester_page/semester_page.dart';
import 'package:note_sharing_project/ui/home/semester_page/semester_page_web.dart';

class SemesterPageBuilder extends StatelessWidget {
  final String selectedProgram;
  const SemesterPageBuilder({
    Key? key,
    required this.selectedProgram,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth > 1000) {
          return SemesterPageWeb(
            selectedProgram: selectedProgram,
          );
        } else if (constraints.maxWidth > 600 && constraints.maxWidth < 1000) {
          return SemesterPage(
            selectedProgram: selectedProgram,
            gridCount: 3,
          );
        } else {
          return SemesterPage(
            selectedProgram: selectedProgram,
            gridCount: 2,
          );
        }
      }),
    );
  }
}
