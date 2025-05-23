import 'package:flutter/material.dart';
import 'package:mobile_app/view/screen/HomeScreen.dart';
import 'package:mobile_app/view/screen/RegisterScreen_2.dart';

import '../view/screen/LoginScreen.dart';
import '../view/screen/RegisterScreen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.root: // bắt buộc xử lý '/'
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppRoutes.register_2:
        final phoneNumber = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => RegisterScreen_2(phoneNumber: phoneNumber ?? ""),
        );
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // case AppRoutes.productDetail:
      //   final productId = settings.arguments as String?;
      //   return MaterialPageRoute(
      //     builder: (_) => ProductDetailScreen(id: productId),
      //   );

      default: // trang 404 an toàn
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 – Page not found')),
              ),
        );
    }
  }
}
