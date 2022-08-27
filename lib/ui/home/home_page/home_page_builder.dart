import 'package:flutter/cupertino.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page_web.dart';

class HomePageBuilder extends StatelessWidget {
  const HomePageBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth < 700) {
          return const HomePage();
        } else if (constraints.maxWidth < 1000) {
          return const HomePageWeb(
            gridCount: 3,
          );
        } else {
          return const HomePageWeb(
            gridCount: 4,
          );
        }
      }),
    );
  }
}
