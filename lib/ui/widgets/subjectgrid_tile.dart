import 'package:flutter/material.dart';
import 'package:note_sharing_project/ui/screens/file_page.dart';

class SubjectGridTile extends StatelessWidget {
  final String semester;
  final String program;
  final String name;
  const SubjectGridTile({
    Key? key,
    required this.name,
    required this.semester,
    required this.program,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => FilePage(
                    name: name,
                    semester: semester,
                    program: program,
                  )))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // color: MyColor.cream,
          ),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/folder.png"),
              ),
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
