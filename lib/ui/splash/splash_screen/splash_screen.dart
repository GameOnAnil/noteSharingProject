import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/services/auth_service.dart';
import 'package:note_sharing_project/ui/splash/auth_wrapper_page/auth_wrapper_page.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

import '../../../providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void checkUser() async {
    final uid = AuthService().getUser();
    if (uid != null) {
      ref.read(authProviderNotifier).setUser(uid);
    }
  }

  void navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const AuthWrapperPage())),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Lottie.asset('assets/animations/splashanimation.json',
              repeat: false),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "N",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                  color: Colors.orange),
            ),
            TextSpan(
              text: "otes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.sp,
                color: purpleText,
              ),
            ),
            TextSpan(
              text: "S",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                  color: Colors.orange),
            ),
            TextSpan(
              text: "haring",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.sp,
                color: purpleText,
              ),
            ),
            TextSpan(
              text: "A",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                  color: Colors.orange),
            ),
            TextSpan(
              text: "pp",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.sp,
                color: purpleText,
              ),
            ),
          ]),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .32,
        ),
      ],
    ));
  }
}
