import 'package:flutter/material.dart';
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
            const SizedBox(height: 20),
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
          Lottie.network(
              "https://assets8.lottiefiles.com/packages/lf20_jcikwtux.json",
              fit: BoxFit.fill),
          Positioned(bottom: 0, left: 0, child: _title())
        ],
      ),
    );
  }

  Padding _textFieldsPart() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              label: const Text("Enter Email"),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                label: const Text("Enter Password"),
                suffixIcon: const Icon(Icons.visibility)),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                label: const Text("Confirm Password"),
                suffixIcon: const Icon(Icons.visibility)),
          ),
          const SizedBox(height: 16),
          _signupButton()
        ],
      ),
    );
  }

  Text _title() {
    return const Text(
      'Sign Up',
      style: TextStyle(
        color: purplePrimary,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }

  Container _signupButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: purplePrimary),
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
