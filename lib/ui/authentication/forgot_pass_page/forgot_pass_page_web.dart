import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/ui/authentication/widgets/custom_text_field.dart';
import 'package:note_sharing_project/ui/authentication/widgets/title_text.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class ForgotPasswordPageWeb extends StatefulWidget {
  const ForgotPasswordPageWeb({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPageWeb> createState() => _ForgotPasswordPageWebState();
}

class _ForgotPasswordPageWebState extends State<ForgotPasswordPageWeb> {
  late TextEditingController emailController;
  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: 600,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset("assets/animations/forgotpass.json",
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .35),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TitleText(
                    title: "Reset Password",
                    fontSize: 24.sp,
                  ),
                ),
                CustomTextField(
                  controller: emailController,
                  label: "Enter Email Address",
                  validator: (value) {},
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: purplePrimary),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
