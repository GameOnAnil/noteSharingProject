import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: purplePrimary),
            accountEmail: Text(
              "test@gmail.com",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            accountName: Text(
              "Anil Thapa",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmDmmRze0UvLaOtjgNVcOhRjmHH0dL0GP18w&usqp=CAU")),
          ),
          Expanded(
            child: Column(
              children: [
                DrawerTile(
                  title: "Profile",
                  icon: FontAwesomeIcons.userLarge,
                ),
                DrawerTile(
                  title: "Downloads",
                  icon: FontAwesomeIcons.download,
                ),
                DrawerTile(
                  title: "About Us",
                  icon: FontAwesomeIcons.addressBook,
                ),
                DrawerTile(
                  title: "Share",
                  icon: FontAwesomeIcons.share,
                ),
                const Expanded(child: SizedBox()),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(color: Colors.black),
                ),
                DrawerTile(
                  title: "Sign Out",
                  icon: FontAwesomeIcons.arrowRightFromBracket,
                ),
                const SizedBox(height: 50)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  String title;
  IconData icon;
  DrawerTile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        icon,
        size: 18,
        color: purplePrimary,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      onTap: () {},
    );
  }
}
