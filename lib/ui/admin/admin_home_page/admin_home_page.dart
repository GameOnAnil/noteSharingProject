import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/models/report_file_model.dart';
import 'package:note_sharing_project/providers/admin_page_notifier.dart';
import 'package:note_sharing_project/ui/admin/admin_home_page/widgets/report_file_tile.dart';
import 'package:note_sharing_project/ui/home/widgets/navigation_drawer.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class AdminHomePage extends ConsumerStatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends ConsumerState<AdminHomePage> {
  @override
  void initState() {
    ref.read(adminPageNotifierProvider).getReportFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purplePrimary,
      extendBodyBehindAppBar: false,
      appBar: _buildAppBar(),
      bottomNavigationBar: _bottomNavBar(context),
      drawer: const NavigationDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.r),
                  topLeft: Radius.circular(30.r),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final fileList =
                            ref.watch(adminPageNotifierProvider).reportFileList;
                        final isLoading =
                            ref.watch(adminPageNotifierProvider).isLoading;

                        if (isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (fileList.isEmpty) {
                          return _listEmpty();
                        } else {
                          //return _listView(fileList);
                          return _gridView(fileList, 2);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _gridView(List<ReportFileModel> fileList, int gridCount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount, childAspectRatio: .85),
          itemCount: fileList.length,
          itemBuilder: (context, index) {
            return ReportFileGridTile(fileModel: fileList[index]);
          }),
    );
  }

  Column _listEmpty() {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Lottie.asset("assets/animations/empty_list.json"),
        Text(
          'No Files Found.',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 24.sp,
          ),
        ),
      ],
    );
  }

  ClipRRect _bottomNavBar(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          // topLeft: Radius.circular(16.r),
          // topRight: Radius.circular(16.r),
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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Admin",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
        ),
      ),
    );
  }
}
