import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/color_manager.dart';
import '../../../../../core/theme/style_manager.dart';

class CartRow extends StatelessWidget {
  final String? title;
  final double? price;
  final TextStyle? style;
  final String? newPattern;

  const CartRow({
    super.key,
    this.title,
    this.price,
    this.style,
    this.newPattern,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? '', style: style ?? StyleManager.headingSubTitle),
        Text(
          '\$ ${NumberFormat(newPattern ?? '#,##0.##').format(price ?? 0)}',
          style: StyleManager.headingSubTitle.copyWith(
            color: ColorManager.primaryDarkColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
