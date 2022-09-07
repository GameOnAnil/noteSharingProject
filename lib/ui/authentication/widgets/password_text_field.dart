import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatefulWidget {
  final String? labelText;
  final TextEditingController controller;
  final Function(String? value) validator;

  const PasswordTextField({
    Key? key,
    this.labelText,
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
          label: Text(widget.labelText ?? 'Enter Password'),
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
