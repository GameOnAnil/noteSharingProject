import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/providers/login_page_notifier.dart';
import 'package:note_sharing_project/services/auth_service.dart';
import 'package:note_sharing_project/ui/authentication/forgot_pass_page.dart';
import 'package:note_sharing_project/ui/authentication/sign_up_page.dart';
import 'package:note_sharing_project/ui/authentication/widgets/custom_text_field.dart';
import 'package:note_sharing_project/ui/authentication/widgets/password_text_field.dart';
import 'package:note_sharing_project/ui/authentication/widgets/title_text.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  _validateForm(WidgetRef ref) {
    if (_globalKey.currentState!.validate()) {
      ref
          .read(authServiceProvider)
          .signIn(emailController.text.trim(), passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _globalKey,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              _header(context),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Consumer(builder: (context, ref, child) {
                    final isLoading =
                        ref.watch(loginPageNotifierProvider).isLoading;
                    final error = ref.watch(loginPageNotifierProvider).error;
                    ref.listen(loginPageNotifierProvider, (previous, next) {
                      if (error != null) {
                        Fluttertoast.showToast(msg: error);
                      }
                    });
                    if (isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return _contentPart(context, ref);
                    }
                  }),
                ),
              ),
            ],
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
          Positioned(
            bottom: 0,
            left: 0,
            child: TitleText(
              title: "Login",
              fontSize: 32.sp,
            ),
          )
        ],
      ),
    );
  }

  Padding _contentPart(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: 24.0.w, right: 24.w, bottom: 24.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            _loginTextField(),
            SizedBox(height: 16.h),
            PasswordTextField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Password";
                  }
                }),
            SizedBox(height: 16.h),
            _forgotPassword(),
            SizedBox(height: 16.h),
            _loginButton(context, ref),
            SizedBox(height: 16.h),
            _divider(),
            SizedBox(height: 16.h),
            _googleSignIn(),
            SizedBox(height: 10.h),
            _signUpText(context),
          ],
        ),
      ),
    );
  }

  GestureDetector _forgotPassword() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const ForgotPasswordPage()),
          ),
        );
      },
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: bluePrimary,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  CustomTextField _loginTextField() {
    return CustomTextField(
      controller: emailController,
      label: "Enter Email",
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Email";
        }
      },
    );
  }

  Padding _signUpText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dont Have An Account?',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),
          GestureDetector(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const SignUpPage()),
                ),
              );
            }),
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: purpleText,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r), color: purplePrimary),
      child: TextButton(
        onPressed: () {
          // _validateForm(ref);
          ref
              .read(loginPageNotifierProvider)
              .signIn("new@gmail.com", "password");
        },
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Container _googleSignIn() {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: bluePrimary),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/google.png",
              width: 30.w,
              height: 30.h,
            ),
          ),
          SizedBox(width: 20.w),
          const Text("Sign in with Google "),
        ],
      ),
    );
  }

  Row _divider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.black)),
        SizedBox(width: 5.w),
        const Text("or"),
        SizedBox(width: 5.w),
        const Expanded(child: Divider(color: Colors.black)),
      ],
    );
  }
}
