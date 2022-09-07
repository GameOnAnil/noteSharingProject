import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/ui/authentication/widgets/password_text_field.dart';
import 'package:note_sharing_project/utils/base_page.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

import '../../../services/auth_service.dart';

class SignUpPageWeb extends BaseStatefulWidget {
  const SignUpPageWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpPageWeb> createState() => _SignUpPageWebState();
}

class _SignUpPageWebState extends ConsumerState<SignUpPageWeb> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Center(
          child: Container(
            width: 600,
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  _header(context),
                  _textFieldsPart(),
                ],
              ),
            ),
          ),
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
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
              label: const Text("Enter Email"),
            ),
            controller: emailController,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Please Enter Email";
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          PasswordTextField(
              controller: passwordController,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Password cannot be empty.";
                }
                return null;
              }),
          SizedBox(height: 16.h),
          PasswordTextField(
            labelText: "Confirm Password",
            controller: confirmPassController,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Confirm password cannot be empty.";
              }
              if (value != passwordController.text) {
                return "Password does not match.";
              }
              return null;
            },
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
        onPressed: () async {
          if (_globalKey.currentState?.validate() ?? true) {
            widget.showProgressDialog(context);
            final response = await ref.read(authServiceProvider).signUp(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
            widget.dismissProgressDialog();
            if (response == "Success") {
              Fluttertoast.showToast(msg: "Signup successfull.");
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(msg: response);
            }
          }
        },
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
