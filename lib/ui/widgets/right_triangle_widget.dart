import 'package:flutter/material.dart';

class RightTriangleWidget extends StatelessWidget {
  const RightTriangleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/rightTriangle.png",
      width: 14,
      height: 14,
      color: Colors.black.withOpacity(.6),
    );
  }
}
