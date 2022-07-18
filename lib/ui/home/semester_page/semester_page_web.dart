import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/sub_notifier.dart';
import 'package:note_sharing_project/ui/home/semester_page/widgets/subject_grid_tile_web.dart';
import 'package:note_sharing_project/ui/home/widgets/navigation_drawer.dart';
import 'package:note_sharing_project/utils/constants.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class SemesterPageWeb extends StatefulWidget {
  final String selectedProgram;
  const SemesterPageWeb({
    Key? key,
    required this.selectedProgram,
  }) : super(key: key);

  @override
  State<SemesterPageWeb> createState() => _SemesterPageWebState();
}

class _SemesterPageWebState extends State<SemesterPageWeb> {
  String? selectedSem;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const NavigationDrawer(),
        Expanded(
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            backgroundColor: lightPurpleBackground,
            appBar: _buildAppBar(widget.selectedProgram),
            body: Column(
              children: [
                _header(),
                Expanded(child: _contentBody()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(String programName) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: purpleText,
      elevation: 0,
      centerTitle: true,
      title: Text(
        programName,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
        ),
      ),
    );
  }

  Widget _chooseSemester() {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: EdgeInsets.all(8.0.r),
        child: SizedBox(
          height: 60.h,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true),
            elevation: 10,
            hint: Text(
              "Choose Semester",
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            isExpanded: true,
            value: selectedSem,
            borderRadius: BorderRadius.circular(10.r),
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
                log("selected sem :$selectedSem");
                if (selectedSem != null) {
                  ref.read(subNotifierProvider).getSubByCategoryLocal(
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
          //  color: Colors.white,
        ),
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
        SizedBox(
          width: 400,
          height: 400,
          child: Image.asset(
            "assets/images/enter sem.png",
            fit: BoxFit.contain,
          ),
        ),
        Text(
          "No Semester Selected.",
          style: TextStyle(fontSize: 24.sp, color: purpleText),
        ),
      ],
    );
  }

  Widget _header() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: Text(
                  'Choose Semester',
                  style: GoogleFonts.montserrat(
                    color: purpleText,
                    fontWeight: FontWeight.w600,
                    fontSize: 30.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              _chooseSemester()
            ],
          ),
        ),
      ),
    );
  }

  _gridView(List<Subject> subList) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.h, left: 16.w, right: 16.w),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: subList.length,
        itemBuilder: (context, index) {
          final remainder = index % 4;
          final currentSubject = subList[index];
          return SubjectGridTileWeb(
            colors: colorGradientList[remainder],
            subject: currentSubject,
            onTap: () {},
          );
        },
      ),
    );
  }
}
