import 'package:flutter/material.dart';
import 'package:note_sharing_project/ui/screens/file_page.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class SubjectGridTile extends StatefulWidget {
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
  State<SubjectGridTile> createState() => _SubjectGridTileState();
}

class _SubjectGridTileState extends State<SubjectGridTile> {
  bool notificationIsOn = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => FilePage(
                name: widget.name,
                semester: widget.semester,
                program: widget.program,
                isNotificationOn: notificationIsOn,
              )),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
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
                widget.name,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    notificationIsOn = !notificationIsOn;
                  });
                },
                icon: (notificationIsOn)
                    ? const Icon(Icons.notifications_active)
                    : const Icon(Icons.notifications_off),
              ),
            )
          ],
        ),
      ),
    );
  }
}
