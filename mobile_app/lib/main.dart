import 'package:flutter/material.dart';
import 'package:mobile_app/routers/app_router.dart';
import 'package:mobile_app/routers/app_routes.dart';
import 'package:mobile_app/view/screen/DetailScreen.dart';
import 'package:mobile_app/view/screen/HomeScreen.dart';
import 'package:mobile_app/view/screen/LoginScreen.dart';

void main() {
  runApp(const GozicTest());
}

class GozicTest extends StatelessWidget {
  const GozicTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "New Flutter App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: DetailScreen(),
      // initialRoute: AppRoutes.login,
      // onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
