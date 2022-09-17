import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/ui/splash/auth_wrapper_page/auth_wrapper_page.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const AuthWrapperPage())),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: 600,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Lottie.asset(
                        'assets/animations/splashanimation.json',
                        repeat: false,
                        height: 500,
                        width: 400),
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
              ),
            ),
          ),
        ));
  }
}
