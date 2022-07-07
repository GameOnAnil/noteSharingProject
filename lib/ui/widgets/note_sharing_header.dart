import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
          // color: purplePrimary,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Lottie.network(
                "https://assets8.lottiefiles.com/packages/lf20_jcikwtux.json"),
          ),
          // const Center(
          //   child: Text(
          //     'Note Sharing App',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 32,
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 50,
          // ),
          // Container(
          //   height: 30,
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(35),
          //       topRight: Radius.circular(35),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
