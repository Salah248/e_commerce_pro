import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/ui/screens/main/Pages/account_page.dart';
import 'package:e_commerce_pro/ui/screens/main/Pages/home_page.dart';
import 'package:e_commerce_pro/ui/screens/main/Pages/my_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> _items;

  int _selectedIndex = 1;
  @override
  void initState() {
    _items = [
      Container(),
      const HomePage(),
      const MyCartPage(),
      const AccountPage(),
      Container(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 86.h,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: ColorManager.borderColor, width: 1.w),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) {
            if (value == 0 || value == 4) return;
            setState(() {
              _selectedIndex = value;
            });
          },
          selectedItemColor: ColorManager.primaryColor,
          unselectedItemColor: ColorManager.secondaryColor,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          elevation: 0,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Account',
            ),
            BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          ],
        ),
      ),
      body: _items[_selectedIndex],
    );
  }
}
