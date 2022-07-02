import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String? value) validator;

  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          label: const Text('Enter Password'),
          suffix: GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: (isVisible)
                ? const Icon(Icons.visibility)
                : const Icon(
                    Icons.visibility_off,
                  ),
          )),
      obscureText: !isVisible,
      validator: (value) {
        return widget.validator(value);
      },
    );
  }
}
