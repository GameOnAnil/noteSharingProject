import 'package:flutter/material.dart';
import 'package:note_sharing_project/ui/screens/home_page.dart';
import 'package:note_sharing_project/ui/screens/sign_up_page.dart';
import 'package:note_sharing_project/ui/widgets/note_sharing_header.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NoteSharingHeader(),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: bluePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          label: const Text("Enter Email"),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            label: const Text("Enter Password"),
                            suffixIcon: const Icon(Icons.visibility)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: bluePrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _loginButton(context),
                      const SizedBox(height: 16),
                      _divider(),
                      const SizedBox(height: 16),
                      _googleSignIn(),
                      const SizedBox(height: 10),
                      _signUpText(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                color: Colors.blueAccent,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _loginButton(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: bluePrimary),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const HomePage()),
            ),
          );
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
        borderRadius: BorderRadius.circular(10),
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
