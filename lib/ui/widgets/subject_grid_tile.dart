import 'package:flutter/material.dart';
import 'package:note_sharing_project/ui/screens/file_page.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

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
              )),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: lightBlueBackground),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/folder2.png",
                width: 120,
                height: 120,
                // color: Colors.blue,
              ),
              Center(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
