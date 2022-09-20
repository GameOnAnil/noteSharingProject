import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/ui/home/widgets/carousel_tile.dart';
import 'package:note_sharing_project/utils/base_utils.dart';
import 'package:note_sharing_project/utils/constants.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

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
        SizedBox(height: 16.h),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .95),
              itemCount: programList.length,
              itemBuilder: (context, index) {
                return CarauselTile(
                    color: caroucelColorList[index % 4],
                    title: programList[index]);
              }),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  SizedBox _buildCaroucelSlider() {
    return SizedBox(
      // width: double.infinity,
      child: CarouselSlider(
        items: programList.map((e) {
          final index = programList.indexOf(e);

          return CarauselTile(color: caroucelColorList[index % 4], title: e);
        }).toList(),
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            setState(() {
              mIndex = index;
            });
          },
          autoPlay: false,
          //aspectRatio: .5,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}

class FolderHorizontalCard extends StatelessWidget {
  final Subject subject;
  const FolderHorizontalCard({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/folderpurple.png",
                    width: 50.w,
                    height: 50.h,
                  ),
                ),
                Center(
                  child: Text(
                    getPathFromSubject(subject),
                    style: TextStyle(
                      color: purpleText,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Files',
                    style: TextStyle(
                      color: purpleText,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
