import 'package:flutter/material.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class ProgramPage extends StatelessWidget {
  const ProgramPage({Key? key}) : super(key: key);

  static const List<String> programList = [
    "BESE",
    "BEIT",
    "BECM",
    "ELECTRONIC",
    "CIVIL",
  ];
  static const List<String> semList = [
    "1st",
    "2nd",
    "3rd",
    "4th",
    "5th",
    "6th",
    "7th",
    "8th",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Container _body() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _selectProgramText(),
          Expanded(child: _gridView()),
        ],
      ),
    );
  }

  Text _selectProgramText() {
    return const Text(
      'Select Program',
      style: TextStyle(
        color: bluePrimary,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    );
  }

  GridView _gridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.1),
      itemCount: semList.length,
      itemBuilder: (context, index) {
        return ProgramGridTile(
          title: semList[index],
        );
      },
    );
  }

  Padding _header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Text(
            'Welcome to ',
            style: TextStyle(
              color: Colors.white.withOpacity(.7),
              fontWeight: FontWeight.w400,
              fontSize: 21,
            ),
          ),
          Text(
            'Note Sharing App',
            style: TextStyle(
              color: Colors.white.withOpacity(.9),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class ProgramGridTile extends StatelessWidget {
  final String title;
  const ProgramGridTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/folder2.png"),
                fit: BoxFit.contain)),
        child: Center(child: Text(title)));
  }
}
