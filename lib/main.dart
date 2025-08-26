import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/routes/route_manager.dart';
import 'package:e_commerce_pro/core/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  initDi();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Ecommerce App pro',
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.lightTheme,
          routerConfig: RouteManager.router,
        );
      },
    );
  }
}
