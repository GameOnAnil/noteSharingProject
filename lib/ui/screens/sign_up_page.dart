import 'package:flutter/material.dart';
import 'package:note_sharing_project/ui/widgets/note_sharing_header.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NoteSharingHeader(),
            _textFieldsPart(),
          ],
        ),
      ),
    );
  }

  Padding _textFieldsPart() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(
              color: bluePrimary,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
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

  Container _signupButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: bluePrimary),
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
