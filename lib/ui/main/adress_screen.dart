import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdressScreen extends StatefulWidget {
  const AdressScreen({super.key});

  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  List<Widget> get _items => [
    _customItem(
      title: 'Home',
      subTitle: '925 S Chugach St #APT 10, Alas...',
      isHome: true,
    ),
    _customItem(title: 'Office', subTitle: '925 S Chugach St #APT 10, Alas...'),
    _customItem(
      title: 'Apartment',
      subTitle: '925 S Chugach St #APT 10, Alas...',
    ),
    _customItem(
      title: 'Parent’s House',
      subTitle: '925 S Chugach St #APT 10, Alas...',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Account',
          style: StyleManager.headingTitle.copyWith(fontSize: 24.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(color: ColorManager.borderColor, thickness: 1),
            SizedBox(height: 20.h),
            Text(
              'Saved Address',
              style: StyleManager.headingTitle.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 14.h),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => _items[index],
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemCount: _items.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customItem({
    required String? title,
    required String? subTitle,
    bool? isHome = false,
  }) {
    return Container(
      height: 92.h,
      width: 341.w,
      padding: EdgeInsets.symmetric(horizontal: 39.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.borderColor, width: 1.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.location_on_outlined,
            color: ColorManager.secondaryColor,
            size: 28.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              isHome!
                  ? Row(
                      children: [
                        Text(
                          title ?? '',
                          style: StyleManager.headingTitle.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        Container(
                          width: 52.w,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorManager.borderColor,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Default',
                            style: StyleManager.textFieldTitle.copyWith(
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title ?? '',
                      style: StyleManager.headingTitle.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
              SizedBox(height: 4.h),
              Text(
                subTitle ?? 'null',
                style: StyleManager.headingSubTitle.copyWith(fontSize: 14.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
