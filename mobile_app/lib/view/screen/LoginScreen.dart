import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_app/controller/authController/AuthController.dart';
import 'package:mobile_app/model/request/LoginRequest.dart';
import 'package:mobile_app/routers/app_routes.dart';
import 'package:mobile_app/view/widget/ButtonWidget.dart';
import 'package:mobile_app/view/widget/TextFieldWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber = "";
  String password = "";

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
              Center(
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Chào mừng bạn trở lại",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),

              Image.asset("assets/image/logo.png", height: 200),
              SizedBox(height: 15),
              TextFieldWidget(
                label: "Nhập số điện thoại",
                onChanged: (value) {
                  phoneNumber = value;
                },
                rightIcon: Icons.phone,
                showPassword: false,
                readOnly: false,
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                label: "Nhập mật khẩu",
                onChanged: (value) {
                  password = value;
                },
                rightIcon: Icons.lock,
                showPassword: true,
                readOnly: false,
              ),
              SizedBox(height: 50),
              ButtonWidget(
                onPressed: () async {
                  final loginModel = LoginRequest(
                    user_phone: phoneNumber,
                    password: password,
                  );

                  final response = await AuthController().login(loginModel);

                  if (response['success'] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Đăng nhập thành công"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushNamed(context, AppRoutes.home);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          response['message'] ?? 'Đăng nhập thất bại',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                text: "ĐĂNG NHẬP",
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ForgotPassword()),
                      // );
                    },
                    child: Text(
                      "Quên mật khẩu?",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
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
  }
}
