import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/ui/screens/file_page.dart';
import 'package:note_sharing_project/ui/widgets/notification_bell_dialog.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class SubjectGridTile extends StatefulWidget {
  final Subject subject;
  const SubjectGridTile({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  State<SubjectGridTile> createState() => _SubjectGridTileState();
}

class _SubjectGridTileState extends State<SubjectGridTile> {
  late bool notificationIsOn;
  late String path;
  @override
  void initState() {
    super.initState();
    notificationIsOn = widget.subject.notificationOn;
    path =
        "${widget.subject.program}-${widget.subject.semester}-${widget.subject.name}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => FilePage(
                name: widget.subject.name,
                semester: widget.subject.semester,
                program: widget.subject.program,
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
                widget.subject.name,
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
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return NotificationBellDialog(
                          subject: widget.subject,
                          onChange: () {
                            setState(() {
                              notificationIsOn = !notificationIsOn;
                            });
                          },
                        );
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
