import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog2 extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? child;
  final String? buttonText;
  final Function()? onTap;

  const CustomAlertDialog2(
      {Key? key,
      this.title,
      this.message,
      this.child,
      this.buttonText,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .7,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    message ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  child ?? const SizedBox(),
                  SizedBox(height: 8.h),
                  ElevatedButton(
                    onPressed: onTap,
                    child: Text(buttonText ?? ""),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
