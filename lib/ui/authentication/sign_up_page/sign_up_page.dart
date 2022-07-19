import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _header(context),
            _textFieldsPart(),
          ],
        ),
      ),
    );
  }

  SizedBox _header(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Lottie.asset("assets/animations/login.json", fit: BoxFit.fill),
          Positioned(bottom: 0, left: 0, child: _title())
        ],
      ),
    );
  }

  Padding _textFieldsPart() {
    return Padding(
      padding: EdgeInsets.only(left: 24.0.w, right: 24.w, bottom: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
              label: const Text("Enter Email"),
            ),
          ),
          SizedBox(height: 16.h),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                label: const Text("Enter Password"),
                suffixIcon: const Icon(Icons.visibility)),
          ),
          SizedBox(height: 16.h),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                label: const Text("Confirm Password"),
                suffixIcon: const Icon(Icons.visibility)),
          ),
          SizedBox(height: 16.h),
          _signupButton()
        ],
      ),
    );
  }

  Text _title() {
    return Text(
      'Sign Up',
      style: TextStyle(
        color: purplePrimary,
        fontWeight: FontWeight.bold,
        fontSize: 32.sp,
      ),
    );
  }

  Container _signupButton() {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: purplePrimary),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
