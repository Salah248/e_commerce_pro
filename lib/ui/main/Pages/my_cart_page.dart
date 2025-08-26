import 'package:e_commerce_pro/shared/provider/cart_provider.dart';
import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:e_commerce_pro/shared/widgets/custom_button.dart';
import 'package:e_commerce_pro/shared/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MyCartPage extends ConsumerStatefulWidget {
  const MyCartPage({super.key});

  @override
  ConsumerState<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends ConsumerState<MyCartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cartProvider.notifier).getCarts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              Text(
                'My Cart',
                style: StyleManager.headingTitle.copyWith(fontSize: 24.sp),
              ),
              SizedBox(height: 20.h),
              cartState.when(
                data: (carts) {
                  if (carts.isEmpty) {
                    return Center(
                      child: Text(
                        'Cart is empty',
                        style: StyleManager.cardTitle,
                      ),
                    );
                  }

                  final cart = carts[0]; // Assuming first cart
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 14.h),
                    itemCount: cart.products!.length,
                    itemBuilder: (context, index) {
                      final product = cart.products![index];
                      return _customItem(
                        title: product.productId.toString(),
                        size: 'size',
                        image: '',
                        price: 1500,
                        cartIndex: 0,
                        productIndex: index, // Use index, not productId
                        quantity: product.quantity ?? 0,
                      );
                    },
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    'Error loading cart',
                    style: StyleManager.cardTitle,
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
              SizedBox(height: 100.h),
              _customRow(title: 'Sub-total', price: 5870),
              SizedBox(height: 16.h),
              _customRow(title: 'VAT (%)', price: 0, newPattern: '0.00'),
              SizedBox(height: 16.h),
              _customRow(title: 'Shipping fee', price: 80),
              SizedBox(height: 16.h),
              Divider(
                color: ColorManager.borderColor.withOpacity(0.5),
                thickness: 1,
              ),
              SizedBox(height: 16.h),
              _customRow(
                title: 'Total',
                price: 5950,
                style: StyleManager.headingSubTitle.copyWith(
                  color: ColorManager.primaryDarkColor,
                ),
              ),
              SizedBox(height: 30.h),
              CustomButton(
                onPressed: () {},
                width: 341.w,
                height: 54.h,
                iconAlignment: IconAlignment.end,
                buttonTitle: 'Go To Checkout',
                icon: const FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: ColorManager.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customItem({
    required String? title,
    required String? size,
    required String? image,
    required double? price,
    int? cartIndex,
    int? productIndex,
    required int quantity,
  }) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? 'title',
                          style: StyleManager.headingTitle.copyWith(
                            fontSize: 16.sp,
                          ),
                          maxLines: 2,
                        ),
                        Text(
                          'Size ${size ?? 'size'}',
                          style: StyleManager.headingSubTitle.copyWith(
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    InkWell(
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
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${NumberFormat('#,##00').format(price ?? 0)}',
                      style: StyleManager.headingTitle.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        _quantityButton(
                          icon: Icons.remove,
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .decrementQuantity(cartIndex!, productIndex!);
                          },
                        ),
                        Text(
                          '$quantity',
                          style: StyleManager.headingTitle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        _quantityButton(
                          icon: Icons.add,
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .incrementQuantity(cartIndex!, productIndex!);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.borderColor.withOpacity(0.3),
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8.r),
          child: Icon(icon, size: 18.sp, color: ColorManager.primaryDarkColor),
        ),
      ),
    );
  }

  Widget _customRow({
    required String? title,
    required double? price,
    TextStyle? style,
    String? newPattern,
  }) {
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
