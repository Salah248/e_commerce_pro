import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onPressed, required this.buttonTitle});
  final void Function()? onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(325.w, 50.h),
        alignment: Alignment.center,
        backgroundColor: ColorManager.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonTitle, style: StyleManager.buttonTitle),
    );
  }
}
