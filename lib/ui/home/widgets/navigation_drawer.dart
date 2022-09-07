import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_sharing_project/providers/auth_provider.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: purplePrimary),
            accountEmail: Text(
              "test@gmail.com",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
            accountName: Text(
              "Anil Thapa",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmDmmRze0UvLaOtjgNVcOhRjmHH0dL0GP18w&usqp=CAU",
            )),
          ),
          Expanded(
            child: Column(
              children: [
                DrawerTile(
                  title: "Profile",
                  icon: FontAwesomeIcons.userLarge,
                  onTap: () {},
                ),
                DrawerTile(
                  title: "Downloads",
                  icon: FontAwesomeIcons.download,
                  onTap: () {},
                ),
                DrawerTile(
                  title: "About Us",
                  icon: FontAwesomeIcons.addressBook,
                  onTap: () {},
                ),
                DrawerTile(
                  title: "Share",
                  icon: FontAwesomeIcons.share,
                  onTap: () {},
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: const Divider(color: Colors.black),
                ),
                Consumer(builder: (context, ref, child) {
                  return DrawerTile(
                    title: "Sign Out",
                    icon: FontAwesomeIcons.arrowRightFromBracket,
                    onTap: () {
                      // ref.read(authServiceProvider).signOut();
                      ref.read(authProviderNotifier).reset();
                    },
                  );
                }),
                SizedBox(height: 50.h)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;
  const DrawerTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        icon,
        size: 18.r,
        color: purplePrimary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
