import 'package:flutter/material.dart';

class MicrophoneWidget extends StatelessWidget {
  const MicrophoneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
        ),
        child: Center(
          child: Image.asset(
            "assets/images/microphone.png",
            fit: BoxFit.contain,
            width: 28,
            height: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
