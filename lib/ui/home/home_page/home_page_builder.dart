import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page_web.dart';

class HomePageBuilder extends StatelessWidget {
  const HomePageBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth < 600) {
          return const HomePage();
        } else {
          return const HomePageWeb();
        }
      }),
    );
  }
}
