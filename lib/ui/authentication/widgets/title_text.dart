import 'package:flutter/material.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class TitleText extends StatelessWidget {
  final String title;
  final double fontSize;
  const TitleText({
    Key? key,
    required this.title,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: purplePrimary,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}
