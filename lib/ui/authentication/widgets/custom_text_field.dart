import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String? value) validator;
  final Widget? suffix;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.validator,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
          label: Text(label),
          suffix: suffix),
      validator: (value) {
        return validator(value);
      },
    );
  }
}
