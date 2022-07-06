import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sharing_project/ui/widgets/carousel_tile.dart';
import 'package:note_sharing_project/ui/widgets/navigation_drawer.dart';
import 'package:note_sharing_project/utils/my_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText(),
            const SizedBox(height: 20),
            const Expanded(
              child: SizedBox(width: double.infinity, child: HomePageCarosel()),
            ),
            const SizedBox(height: 20),
            _recentFolderText(),
            SizedBox(
                height: 130, width: double.infinity, child: _buildListView()),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(context),
      drawer: const NavigationDrawer(),
    );
  }

  Padding _recentFolderText() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        'Recent Folder',
        style: TextStyle(
          color: purpleText,
          fontWeight: FontWeight.w400,
          fontSize: 24,
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
            fontSize: 32,
          ),
        ),
        Text(
          'Welcome Back',
          style: GoogleFonts.montserrat(
            color: purpleText,
            fontWeight: FontWeight.w600,
            fontSize: 32,
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
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
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
                height: 24,
              ),
              activeIcon: Image.asset(
                "assets/images/home.png",
                height: 24,
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
              items: const [
                CarauselTile(
                  color: purplePrimary,
                  title: "BESE",
                ),
                CarauselTile(
                  color: Colors.red,
                  title: "BEIT",
                ),
                CarauselTile(
                  color: Colors.orange,
                  title: "BCOM",
                ),
                CarauselTile(
                  color: Colors.green,
                  title: "Bsc IT",
                ),
              ],
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
