import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextSpan extends StatelessWidget {
  const CustomTextSpan({
    super.key,
    required this.text,
    required this.textInline,
    this.onTap,
  });
  final String text;
  final String textInline;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(text, style: StyleManager.headingSubTitle),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: onTap,
          child: Text(
            textInline,
            style: StyleManager.textFieldTitle.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: ColorManager.primaryDarkColor,
            ),
          ),
        ),
      ],
    );
  }
}
//  TextSpan(text: text, style: StyleManager.headingSubTitle),
//           TextSpan(
//             text: textInline,
//             style: StyleManager.textFieldTitle.copyWith(
//               decoration: TextDecoration.underline,
//               decorationColor: ColorManager.primaryDarkColor,
//             ),
//           ),