import 'package:flutter/material.dart';
import 'package:mobile_app/controller/authController/AuthController.dart';

import '../../model/request/RegisterRequest.dart';
import '../../routers/app_routes.dart';
import '../widget/ButtonWidget.dart';
import '../widget/TextFieldWidget.dart';

class RegisterScreen_2 extends StatefulWidget {
  final String phoneNumber;

  const RegisterScreen_2({super.key, required this.phoneNumber});

  @override
  State<RegisterScreen_2> createState() => _RegisterScreen_2State();
}

class _RegisterScreen_2State extends State<RegisterScreen_2> {
  String name = "";
  String address = "";
  String password = "";
  String confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    String phoneNumber = widget.phoneNumber;
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
                  "Đăng ký",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Tiếp tục đăng ký tài khoản",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),

              Image.asset("assets/image/logo.png", height: 200),
              SizedBox(height: 15),

              TextFieldWidget(
                label: "Hãy nhập tên của bạn",
                onChanged: (value) {
                  name = value;
                },
                rightIcon: Icons.person_3,
                showPassword: false,
                readOnly: false,
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                label: phoneNumber,
                onChanged: (value) {},
                rightIcon: Icons.phone,
                showPassword: false,
                readOnly: true,
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                label: "Nhập vị trí",
                onChanged: (value) {
                  address = value;
                },
                rightIcon: Icons.location_on_outlined,
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
              SizedBox(height: 25),
              TextFieldWidget(
                label: "Xác nhận mật khẩu",
                onChanged: (value) {
                  confirmPassword = value;
                },
                rightIcon: Icons.lock,
                showPassword: true,
                readOnly: false,
              ),
              SizedBox(height: 50),
              ButtonWidget(
                onPressed: () async {
                  final registerModel = RegisterRequest(
                    phone: widget.phoneNumber,
                    password: password,
                    name: name,
                    address: address,
                    confirmPassword: confirmPassword,
                  );

                  final response = await AuthController().register(
                    registerModel,
                  );

                  if (response['success'] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Đăng ký thành công"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushNamed(context, AppRoutes.login);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          response['message'] ?? 'Đăng ký thất bại',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                text: "Đăng ký",
              ),
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
  }
}
