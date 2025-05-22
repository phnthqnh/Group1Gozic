import 'package:flutter/material.dart';
import 'package:mobile_app/routers/app_routes.dart';

import '../widget/ButtonWidget.dart';
import '../widget/TextFieldWidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            left: 15,
            right: 15,
            bottom: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset("assets/image/logo.png", height: 200),
              SizedBox(height: 15),
              TextFieldWidget(
                label: "Nhập số điện thoại",
                onChanged: (value) {
                  phoneNumber = value;
                  print(phoneNumber);
                },
                rightIcon: Icons.phone,
                showPassword: false,
                readOnly: false,
              ),
              SizedBox(height: 15),
              Text(
                "Sử dụng số điện thoại để kích hoạt tài khoản khi đăng ký",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),

              SizedBox(height: 50),
              ButtonWidget(onPressed: () {
                Navigator.pushNamed(context, AppRoutes.register_2, arguments: phoneNumber);
                print("phoneNumber: $phoneNumber");
              }, text: "TIẾP TỤC"),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn đã có tài khoản?",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
