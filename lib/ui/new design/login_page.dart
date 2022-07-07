import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:note_sharing_project/providers/login_page_notifier.dart';
import 'package:note_sharing_project/services/auth_service.dart';
import 'package:note_sharing_project/ui/new%20design/sign_up_page.dart';
import 'package:note_sharing_project/ui/widgets/custom_text_field.dart';
import 'package:note_sharing_project/ui/widgets/password_text_field.dart';
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
              const SizedBox(height: 20),
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
      // color: Colors.red,
      height: MediaQuery.of(context).size.height * .4,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Lottie.network(
              "https://assets8.lottiefiles.com/packages/lf20_jcikwtux.json",
              fit: BoxFit.fill),
          Positioned(bottom: 0, left: 0, child: _title())
        ],
      ),
    );
  }

  Padding _contentPart(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _loginTextField(),
            const SizedBox(height: 16),
            PasswordTextField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Password";
                  }
                }),
            const SizedBox(height: 16),
            _forgotPassword(),
            const SizedBox(height: 16),
            _loginButton(context, ref),
            const SizedBox(height: 16),
            _divider(),
            const SizedBox(height: 16),
            _googleSignIn(),
            const SizedBox(height: 10),
            _signUpText(context),
          ],
        ),
      ),
    );
  }

  Container _forgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: const Text(
        'Forgot Password?',
        style: TextStyle(
          color: bluePrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
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

  Text _title() {
    return const Text(
      'Login',
      style: TextStyle(
        color: purplePrimary,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }

  Padding _signUpText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Dont Have An Account?',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
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
            child: const Text(
              'Sign Up',
              style: TextStyle(
                color: purpleText,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: purplePrimary),
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
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: bluePrimary),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/google.png",
            width: 30,
            height: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          const Text("Sign in with Google "),
        ],
      ),
    );
  }

  Row _divider() {
    return Row(
      children: const [
        Expanded(
            child: Divider(
          color: Colors.black,
        )),
        SizedBox(
          width: 5,
        ),
        Text("or"),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Divider(
          color: Colors.black,
        )),
      ],
    );
  }
}
