import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/route_manager.dart';
import 'package:e_commerce_pro/resources/style_manager.dart';
import 'package:e_commerce_pro/ui/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory = 'All';
  List<Widget> get _items => [
    _customCategory(data: 'All'),
    _customCategory(data: 'Tshirts'),
    _customCategory(data: 'Jeans'),
    _customCategory(data: 'Shoes'),
  ];
  List<Widget> get _items2 => [
    _customItem(
      image:
          'https://purepng.com/public/uploads/large/purepng.com-t-shirtclothingt-shirtfashion-dress-shirt-cloth-tshirt-631522326894filwv.png',
      title: 'T Shirt',
      price: 1193,
    ),
    _customItem(
      image: 'https://purepng.com/public/uploads/large/jeans-pant-xom.png',
      title: 'Jeans Pant',
      price: 2000,
    ),
    _customItem(
      image:
          'https://purepng.com/public/uploads/large/purepng.com-t-shirtclothingt-shirtfashion-dress-shirt-cloth-tshirt-631522326894filwv.png',
      title: 'T Shirt',
      price: 1193,
    ),
    _customItem(
      image: 'https://purepng.com/public/uploads/large/jeans-pant-xom.png',
      title: 'Jeans Pant',
      price: 2000,
    ),
    _customItem(
      image:
          'https://purepng.com/public/uploads/large/purepng.com-t-shirtclothingt-shirtfashion-dress-shirt-cloth-tshirt-631522326894filwv.png',
      title: 'T Shirt',
      price: 1193,
    ),
    _customItem(
      image: 'https://purepng.com/public/uploads/large/jeans-pant-xom.png',
      title: 'Jeans Pant',
      price: 2000,
    ),
    _customItem(
      image:
          'https://purepng.com/public/uploads/large/purepng.com-t-shirtclothingt-shirtfashion-dress-shirt-cloth-tshirt-631522326894filwv.png',
      title: 'T Shirt',
      price: 1193,
    ),
    _customItem(
      image: 'https://purepng.com/public/uploads/large/jeans-pant-xom.png',
      title: 'Jeans Pant',
      price: 2000,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Discover', style: StyleManager.headingTitle),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(child: _searchField()),
                SizedBox(width: 8.w),
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    alignment: Alignment.center,
                    fixedSize: Size(52.w, 52.w),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  icon: const Icon(Icons.tune, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 36.h,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemCount: _items.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => _items[index],
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: _items2.length,
                padding: EdgeInsets.only(top: 12.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 19.w,
                  mainAxisSpacing: 20.h,
                  childAspectRatio: 0.80,
                ),
                itemBuilder: (context, index) => _items2[index],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(color: ColorManager.borderColor, width: 1),
    );
    return TextField(
      controller: _searchController,
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
            color: ColorManager.secondaryColor.withOpacity(.5),
          ),
        ),
      ),
    );
  }

  Widget _customCategory({String? data}) {
    final bool isSelected = data == _selectedCategory;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        fixedSize: Size.fromHeight(36.h),
        backgroundColor: isSelected
            ? ColorManager.primaryColor
            : ColorManager.whiteColor,

        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10.r),
          side: BorderSide(color: ColorManager.borderColor, width: 1.w),
        ),
      ),
      onPressed: () {
        setState(() {
          _selectedCategory = data;
        });
      },
      child: Text(
        data ?? '',
        style: StyleManager.headingTitle.copyWith(
          color: isSelected
              ? ColorManager.whiteColor
              : ColorManager.primaryDarkColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _customItem({
    required String? image,
    required String? title,
    required int? price,
  }) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.productDetails);
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCachedNetworkImage(
              imageUrl: image,
              width: 161.w,
              height: 174.h,
            ),
            Text(
              title ?? 'Null',
              style: StyleManager.cardTitle.copyWith(fontSize: 16.sp),
            ),
            Text(
              '\$ ${NumberFormat('#,##0').format(price ?? 0)}',
              style: StyleManager.textFieldHint.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
