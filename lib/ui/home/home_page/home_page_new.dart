import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sharing_project/ui/home/home_page/widgets/home_page_caroucel.dart';

import '../../../utils/my_colors.dart';
import '../widgets/navigation_drawer.dart';

class HomePageNew extends StatelessWidget {
  const HomePageNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _bottomNavBar(context),
      drawer: const NavigationDrawer(),
      backgroundColor: purplePrimary,
      extendBodyBehindAppBar: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _contentBody()),
        ],
      ),
    );
  }

  ClipRRect _bottomNavBar(BuildContext context) {
    return ClipRRect(
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

  Container _contentBody() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
            color: Colors.white),
        child: const HomePageCarosel());
  }

  Container _header() {
    return Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: Text(
                'Select Program',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Choose Program",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
        ),
      ),
    );
  }
}
