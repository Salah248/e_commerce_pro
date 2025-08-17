import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.obscureText,
    this.hintText,
    required this.titleText,
    this.suffixIcon,
    this.validator,
  });
  final TextEditingController? controller;
  final bool? obscureText;
  final String? hintText;
  final String titleText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: ColorManager.borderColor, width: 1.w),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleText, style: StyleManager.textFieldTitle),
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          validator:
              validator ??
              (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 15.w,
            ),
            hintText: 'Enter your $hintText',
            helperStyle: StyleManager.textFieldHint,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder.copyWith(
              borderSide: BorderSide(color: ColorManager.redColor, width: 1.w),
            ),
          ),
        ),
      ],
    );
  }
}
