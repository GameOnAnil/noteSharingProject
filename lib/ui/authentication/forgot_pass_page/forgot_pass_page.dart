import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/ui/authentication/widgets/custom_text_field.dart';
import 'package:note_sharing_project/ui/authentication/widgets/title_text.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

import '../../../services/auth_service.dart';
import '../../../utils/base_page.dart';
import '../../../utils/base_state.dart';

class ForgotPasswordPage extends BaseStatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  BaseState<ForgotPasswordPage> createState() => _ForgotPasswordPageWebState();
}

class _ForgotPasswordPageWebState extends BaseState<ForgotPasswordPage> {
  late TextEditingController emailController;
  final globalkey = GlobalKey<FormState>();
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
          child: Form(
            key: globalkey,
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
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please enter email";
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: purplePrimary),
                    child: TextButton(
                      onPressed: () async {
                        if (globalkey.currentState?.validate() ?? false) {
                          _performResertOperation();
                        }
                      },
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
      ),
    );
  }

  Future<void> _performResertOperation() async {
    if (globalkey.currentState?.validate() ?? false) {
      showProgressDialog();
      try {
        final response =
            await AuthService().forgotPassword(email: emailController.text);
        dismissProgressDialog();
        if (response == "Success") {
          Fluttertoast.showToast(msg: "Email Sent Successfully.");
        } else {
          Fluttertoast.showToast(msg: response);
        }
      } catch (e) {
        dismissProgressDialog();
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}
