import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/ui/screens/file_page_new.dart';

class NewSubjectGridTile extends StatelessWidget {
  final List<Color> colors;
  final Subject subject;
  final Function() onTap;
  const NewSubjectGridTile({
    Key? key,
    required this.colors,
    required this.subject,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => FilePageNew(
                  subject: subject,
                )),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/education.png",
              width: 70,
              height: 70,
            ),
            Text(
              subject.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
