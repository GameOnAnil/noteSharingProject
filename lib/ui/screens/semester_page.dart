import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/sub_notifier.dart';
import 'package:note_sharing_project/ui/widgets/new_subject_grid_tile.dart';
import 'package:note_sharing_project/utils/constants.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class SemesterPage extends StatefulWidget {
  final String selectedProgram;
  const SemesterPage({
    Key? key,
    required this.selectedProgram,
  }) : super(key: key);

  @override
  State<SemesterPage> createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  String? selectedSem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: purplePrimary,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(widget.selectedProgram),
      body: Column(
        children: [
          Expanded(flex: 2, child: _header()),
          Expanded(flex: 5, child: _contentBody()),
        ],
      ),
    );
  }

  AppBar _buildAppBar(String programName) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        programName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _chooseSemester() {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 60,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true),
            elevation: 10,
            hint: const Text(
              "Choose Semester",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            isExpanded: true,
            value: selectedSem,
            borderRadius: BorderRadius.circular(10),
            items: [
              ...semesterList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList()
            ],
            onChanged: (item) {
              setState(() {
                selectedSem = item.toString();
                if (selectedSem != null) {
                  ref.read(subNotifierProvider).getSubByCategory(
                      program: widget.selectedProgram, semester: selectedSem!);
                }
              });
            },
          ),
        ),
      );
    });
  }

  Container _contentBody() {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            color: Colors.white),
        child: Consumer(
          builder: (context, ref, child) {
            final subList = ref.watch(subNotifierProvider).subList;
            if (subList.isEmpty) {
              return _listEmpty();
            } else {
              return _gridView(subList);
            }
          },
        ));
  }

  Column _listEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        Image.asset(
          "assets/images/enter sem.png",
          fit: BoxFit.cover,
        ),
        const Text(
          "No Semester Selected.",
          style: TextStyle(fontSize: 24, color: purpleText),
        ),
      ],
    );
  }

  Container _header() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Choose Semester',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _chooseSemester()
          ],
        ),
      ),
    );
  }

  _gridView(List<Subject> subList) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemCount: subList.length,
        itemBuilder: (context, index) {
          final remainder = index % 4;
          final currentSubject = subList[index];
          return NewSubjectGridTile(
            colors: colorGradientList[remainder],
            subject: currentSubject,
            onTap: () {},
          );
        },
      ),
    );
  }
}
