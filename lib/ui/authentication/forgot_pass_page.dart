import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/ui/authentication/widgets/custom_text_field.dart';
import 'package:note_sharing_project/ui/authentication/widgets/title_text.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset("assets/animations/forgotpass.json",
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .35),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: TitleText(
                title: "Reset Password",
                fontSize: 28.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: CustomTextField(
                controller: emailController,
                label: "Enter Email Address",
                validator: (value) {},
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width * .7,
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
    );
  }
}
