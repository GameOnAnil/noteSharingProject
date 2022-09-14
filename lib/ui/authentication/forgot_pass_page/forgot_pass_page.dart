import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/services/auth_service.dart';
import 'package:note_sharing_project/ui/authentication/widgets/custom_text_field.dart';
import 'package:note_sharing_project/ui/authentication/widgets/title_text.dart';
import 'package:note_sharing_project/utils/base_state.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

import '../../../utils/base_page.dart';

class ForgotPasswordPage extends BaseStatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  BaseState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends BaseState<ForgotPasswordPage> {
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
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Form(
        key: globalkey,
        child: SingleChildScrollView(
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
                SizedBox(height: 8.h),
                CustomTextField(
                  controller: emailController,
                  label: "Enter Email Address",
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Please enter email.";
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
                        showProgressDialog();
                        try {
                          final response = await AuthService()
                              .forgotPassword(email: emailController.text);
                          dismissProgressDialog();
                          if (response == "Success") {
                            Fluttertoast.showToast(
                                msg: "Email Sent Successfully.");
                          } else {
                            Fluttertoast.showToast(msg: response);
                          }
                        } catch (e) {
                          dismissProgressDialog();
                          Fluttertoast.showToast(msg: e.toString());
                        }
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
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
