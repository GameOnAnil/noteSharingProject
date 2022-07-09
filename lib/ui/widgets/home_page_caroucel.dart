import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:note_sharing_project/ui/widgets/carousel_tile.dart';
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
        const SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: mIndex,
          count: 4,
          effect: const ScrollingDotsEffect(
              dotWidth: 10, dotHeight: 10, activeDotColor: purplePrimary),
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
        width: 150,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/folderpurple.png",
                  width: 50,
                  height: 50,
                ),
                const Text(
                  'BESE-1ST-C',
                  style: TextStyle(
                    color: purpleText,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  '10 Files',
                  style: TextStyle(
                    color: purpleText,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
