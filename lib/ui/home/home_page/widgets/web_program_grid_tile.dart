import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/ui/home/semester_page/semester_page_builder.dart';

class WebProgramTile extends StatelessWidget {
  final Color color;
  final String title;
  const WebProgramTile({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.sp,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    "Files: 200",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //   const Expanded(child: SizedBox()),
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => SemesterPageBuilder(
                          selectedProgram: title,
                        )),
                  ),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: AutoSizeText(
                "View",
                maxLines: 1,
                style: TextStyle(color: color),
              ),
            ),
          ),
          //  SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
