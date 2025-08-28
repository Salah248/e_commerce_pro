import 'package:e_commerce_pro/shared/provider/main/cart/cart_provider.dart';
import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:e_commerce_pro/shared/widgets/custom_button.dart';
import 'package:e_commerce_pro/ui/main/Pages/cart/widgets/custom_cart_item.dart';
import 'package:e_commerce_pro/ui/main/Pages/cart/widgets/custom_cart_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/model/cart_model.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              _buildTitle(),
              SizedBox(height: 20.h),
              _buildCartItems(),
              SizedBox(height: 100.h),
              _buildCartSummary(),
              SizedBox(height: 30.h),
              _buildCheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'My Cart',
      style: StyleManager.headingTitle.copyWith(fontSize: 24.sp),
    );
  }

  Widget _buildCartItems() {
    final cartState = ref.watch(cartProvider);

    return cartState.when(
      data: (carts) => _buildCartItemsList(carts),
      error: (error, stackTrace) => _buildErrorWidget(),
      loading: () => _buildLoadingWidget(),
    );
  }

  Widget _buildCartItemsList(List<CartModel> carts) {
    if (carts.isEmpty) {
      return _buildEmptyCartWidget();
    }

    // دمج جميع المنتجات من جميع العربات
    final allProducts = <CartProduct>[];
    for (final cart in carts) {
      if (cart.products != null) {
        allProducts.addAll(cart.products!);
      }
    }

    if (allProducts.isEmpty) {
      return _buildEmptyCartWidget();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => SizedBox(height: 14.h),
      itemCount: allProducts.length,
      itemBuilder: (context, index) {
        final product = allProducts[index];
        return CartItem(
          title:
              'Product ${product.productId}', // يمكنك تحسين هذا ليعرض اسم المنتج الحقيقي
          size: 'size',
          image: '',
          price: 1500,
          cartIndex: 0, // قد تحتاج لتعديل هذا
          productIndex: index,
          quantity: product.quantity ?? 0,
        );
      },
    );
  }

  Widget _buildEmptyCartWidget() {
    return Center(child: Text('Cart is empty', style: StyleManager.cardTitle));
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Text('Error loading cart', style: StyleManager.cardTitle),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildCartSummary() {
    return Column(
      children: [
        const CartRow(title: 'Sub-total', price: 5870),
        SizedBox(height: 16.h),
        const CartRow(title: 'VAT (%)', price: 0, newPattern: '0.00'),
        SizedBox(height: 16.h),
        const CartRow(title: 'Shipping fee', price: 80),
        SizedBox(height: 16.h),
        Divider(color: ColorManager.borderColor.withOpacity(0.5), thickness: 1),
        SizedBox(height: 16.h),
        CartRow(
          title: 'Total',
          price: 5950,
          style: StyleManager.headingSubTitle.copyWith(
            color: ColorManager.primaryDarkColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return CustomButton(
      onPressed: () {},
      width: 341.w,
      height: 54.h,
      iconAlignment: IconAlignment.end,
      buttonTitle: 'Go To Checkout',
      icon: const FaIcon(
        FontAwesomeIcons.arrowRight,
        color: ColorManager.whiteColor,
      ),
    );
  }
}
