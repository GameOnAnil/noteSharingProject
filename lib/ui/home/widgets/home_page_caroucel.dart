import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/ui/home/widgets/carousel_tile.dart';
import 'package:note_sharing_project/utils/constants.dart';
import 'package:note_sharing_project/utils/my_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageCarosel extends StatefulWidget {
  const HomePageCarosel({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageCarosel> createState() => _HomePageCaroselState();
}

class _HomePageCaroselState extends State<HomePageCarosel> {
  int mIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: CarouselSlider(
              items: programList.map((e) {
                final index = programList.indexOf(e);

                return CarauselTile(
                    color: caroucelColorList[index % 4], title: e);
              }).toList(),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    mIndex = index;
                  });
                },
                autoPlay: true,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        AnimatedSmoothIndicator(
          activeIndex: mIndex,
          count: 4,
          effect: ScrollingDotsEffect(
              dotWidth: 10.w, dotHeight: 10.h, activeDotColor: purplePrimary),
        ),
      ],
    );
  }
}

class FolderHorizontalCard extends StatelessWidget {
  const FolderHorizontalCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150.w,
        height: 100.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), color: Colors.white),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/folderpurple.png",
                  width: 50.w,
                  height: 50.h,
                ),
                Text(
                  'BESE-1ST-C',
                  style: TextStyle(
                    color: purpleText,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  '10 Files',
                  style: TextStyle(
                    color: purpleText,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
