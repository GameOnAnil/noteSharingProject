import 'package:flutter/material.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class NoteSharingHeader extends StatelessWidget {
  const NoteSharingHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: const BoxDecoration(
        color: darkBlueBackground,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            "assets/images/book_logo.png",
            color: Colors.white,
            width: 100,
            height: 100,
          ),
          const Center(
            child: Text(
              'Note Sharing App',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
