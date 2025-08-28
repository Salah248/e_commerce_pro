import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/color_manager.dart';
import '../../../../../core/theme/style_manager.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, this.controller, this.onChanged});
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(color: ColorManager.borderColor, width: 1),
    );
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        hintText: 'Search for clothes...',
        hintStyle: StyleManager.textFieldHint,
        prefixIcon: IconButton(
          style: IconButton.styleFrom(elevation: 0, padding: EdgeInsets.zero),
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: ColorManager.secondaryColor.withAlpha((.5 * 255).round()),
          ),
        ),
      ),
    );
  }
}
