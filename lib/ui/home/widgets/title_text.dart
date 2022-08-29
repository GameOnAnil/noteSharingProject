import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        color: purpleText,
        fontWeight: FontWeight.w600,
        fontSize: 32.sp,
      ),
    );
  }
}
