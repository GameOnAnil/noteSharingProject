// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sharing_project/ui/home/home_page/widgets/web_program_grid_tile.dart';
import 'package:note_sharing_project/ui/home/widgets/navigation_drawer_web.dart';
import 'package:note_sharing_project/utils/constants.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class HomePageWeb extends StatelessWidget {
  final int gridCount;
  const HomePageWeb({
    Key? key,
    required this.gridCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const NavigationDrawerWeb(),
        Expanded(
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  lightPurpleBackground,
                  lightPurpleBackground2,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderText(),
                      SizedBox(height: 20.h),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          //
                          child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: gridCount,
                                      childAspectRatio: 1),
                              itemCount: programList.length,
                              itemBuilder: (context, index) {
                                return WebProgramTile(
                                    color: caroucelColorList[index % 4],
                                    title: programList[index]);
                              }),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _recentFolderText(),
                      SizedBox(
                        height: 130.h,
                        width: double.infinity,
                        child: _buildListView(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _recentFolderText() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0.h),
      child: Text(
        'Recent Folder',
        style: TextStyle(
          color: purpleText,
          fontWeight: FontWeight.w400,
          fontSize: 24.sp,
        ),
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: ((context, index) {
        // return const FolderHorizontalCard();
        return const SizedBox();
      }),
    );
  }

  Column _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 70,
        ),
        Text(
          'Hello User,',
          style: GoogleFonts.montserrat(
            color: purpleText,
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
          ),
        ),
        Text(
          'Welcome Back',
          style: GoogleFonts.montserrat(
            color: purpleText,
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: const [],
    );
  }
}
