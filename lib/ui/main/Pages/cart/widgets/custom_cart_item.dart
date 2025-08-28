import 'package:e_commerce_pro/ui/main/Pages/cart/widgets/custom_quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/color_manager.dart';
import '../../../../../core/theme/style_manager.dart';
import '../../../../../shared/provider/main/cart/cart_provider.dart';
import '../../../../../shared/widgets/custom_cached_image.dart';

class CartItem extends ConsumerWidget {
  final String? title;
  final String? size;
  final String? image;
  final double? price;
  final int? cartIndex;
  final int? productIndex;
  final int quantity;

  const CartItem({
    super.key,
    this.title,
    this.size,
    this.image,
    this.price,
    this.cartIndex,
    this.productIndex,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorManager.borderColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCachedNetworkImage(
            imageUrl: image,
            width: 83.w,
            height: 85.h,
            radius: 4.r,
          ),
          SizedBox(width: 16.w),
          Expanded(child: _buildItemDetails(ref)),
        ],
      ),
    );
  }

  Widget _buildItemDetails(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitleAndDeleteButton(),
        SizedBox(height: 18.h),
        _buildPriceAndQuantityControls(ref),
      ],
    );
  }

  Widget _buildTitleAndDeleteButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'title',
              style: StyleManager.headingTitle.copyWith(fontSize: 16.sp),
              maxLines: 2,
            ),
            Text(
              'Size ${size ?? 'size'}',
              style: StyleManager.headingSubTitle.copyWith(fontSize: 12.sp),
              maxLines: 1,
            ),
          ],
        ),
        _buildDeleteButton(),
      ],
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        padding: EdgeInsets.all(8.w),
        child: FaIcon(
          FontAwesomeIcons.trashCan,
          color: ColorManager.redColor,
          size: 16.sp,
        ),
      ),
    );
  }

  Widget _buildPriceAndQuantityControls(WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${NumberFormat('#,##00').format(price ?? 0)}',
          style: StyleManager.headingTitle.copyWith(fontSize: 14.sp),
        ),
        _buildQuantityControls(ref),
      ],
    );
  }

  Widget _buildQuantityControls(WidgetRef ref) {
    return Row(
      spacing: 5,
      children: [
        QuantityButton(
          icon: Icons.remove,
          onPressed: () {
            if (cartIndex != null && productIndex != null) {
              ref
                  .read(cartProvider.notifier)
                  .decrementQuantity(cartIndex!, productIndex!);
            }
          },
        ),
        Text(
          '$quantity',
          style: StyleManager.headingTitle.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        QuantityButton(
          icon: Icons.add,
          onPressed: () {
            if (cartIndex != null && productIndex != null) {
              ref
                  .read(cartProvider.notifier)
                  .incrementQuantity(cartIndex!, productIndex!);
            }
          },
        ),
      ],
    );
  }
}
