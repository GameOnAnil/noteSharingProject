import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/ui/home/file_page/file_page.dart';

class SubjectGridTile extends StatelessWidget {
  final List<Color> colors;
  final Subject subject;
  final Function() onTap;
  const SubjectGridTile({
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
            builder: ((context) => FilePage(
                  subject: subject,
                )),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
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
              width: 70.w,
              height: 70.h,
            ),
            Text(
              subject.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 32.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
