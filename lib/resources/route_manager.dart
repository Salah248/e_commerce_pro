import 'package:e_commerce_pro/ui/screens/auth/login_screen.dart';
import 'package:e_commerce_pro/ui/screens/auth/signup_screen.dart';
import 'package:e_commerce_pro/ui/screens/main/adress_screen.dart';
import 'package:e_commerce_pro/ui/screens/main/main_screen.dart';
import 'package:e_commerce_pro/ui/screens/main/product_detailes_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String login = '/';
  static const String signUp = '/signUp';
  static const String main = '/main';
  static const String productDetails = '/productDetails';
  static const String address = '/address';
}

class RouteManager {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.signUp,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: Routes.main,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: Routes.productDetails,
        builder: (context, state) {
          return const ProductDetailsScreen();
        },
      ),
      GoRoute(
        path: Routes.address,
        builder: (context, state) => const AdressScreen(),
      ),
    ],
  );
}
