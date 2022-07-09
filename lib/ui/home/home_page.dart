import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sharing_project/ui/widgets/home_page_caroucel.dart';
import 'package:note_sharing_project/ui/widgets/navigation_drawer.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPurpleBackground,
      appBar: _buildAppBar(context),
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
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText(),
            SizedBox(height: 20.h),
            const Expanded(
              child: SizedBox(width: double.infinity, child: HomePageCarosel()),
            ),
            SizedBox(height: 20.h),
            _recentFolderText(),
            SizedBox(
                height: 130.h, width: double.infinity, child: _buildListView()),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(context),
      drawer: const NavigationDrawer(),
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
      itemCount: 5,
      itemBuilder: ((context, index) {
        return const FolderHorizontalCard();
      }),
    );
  }

  Column _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello Anil,',
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
      backgroundColor: lightPurpleBackground2,
      elevation: 0,
      actions: [
        Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const FaIcon(
              FontAwesomeIcons.bars,
              color: Colors.black,
            ),
          );
        })
      ],
    );
  }

  ClipRRect _bottomNavBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
      child: Builder(builder: (context) {
        return BottomNavigationBar(
          elevation: 8,
          backgroundColor: Colors.white,
          selectedItemColor: purplePrimary,
          onTap: (index) {
            if (index == 1) {
              Scaffold.of(context).openDrawer();
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/home.png",
                height: 24.h,
              ),
              activeIcon: Image.asset(
                "assets/images/home.png",
                height: 24.h,
                color: purplePrimary,
              ),
              label: "Home",
            ),
            const BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: "Profile",
            )
          ],
        );
      }),
    );
  }
}
