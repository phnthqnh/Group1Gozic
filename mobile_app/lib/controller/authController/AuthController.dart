import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app/model/request/LoginRequest.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/model/request/RegisterRequest.dart';
import 'package:mobile_app/model/response/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String baseUrl = "http://10.0.2.2:8000/api";

  //dang nhap
  Future<Map<String, dynamic>> login(LoginRequest request) async {
    // Kiểm tra rỗng
    if (request.user_phone.isEmpty || request.password.isEmpty) {
      return {
        'success': false,
        'message': 'Vui lòng nhập đầy đủ số điện thoại và mật khẩu.',
      };
    }

    final url = Uri.parse("$baseUrl/login/");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(request.toJson()),
      );
      print("Login response body: ${response.body}");

      if (response.statusCode == 200) {
        final loginData = LoginResponse.fromJson(jsonDecode(response.body));
        saveUserToLocal(loginData);
        return {
          'success': true,
          'data': loginData,
        };
      } else {
        print("Login failed: ${response.body}");
        final phoneRegex = RegExp(r"^(0[3|5|7|8|9])+([0-9]{8})$");
        if (!phoneRegex.hasMatch(request.user_phone)) {
          return {
            'success': false,
            'message': 'Số điện thoại không hợp lệ',
          };
        }
        return {
          'success': false,
          'message': 'Sai số điện thoại hoặc mật khẩu.',
        };
      }
    } catch (e) {
      print("Login exception: $e");
      return {
        'success': false,
        'message': 'Có lỗi xảy ra. Vui lòng thử lại.',
      };
    }
  }


  //dang ky
  Future<Map<String, dynamic>> register(RegisterRequest request) async {
    if (request.name.isEmpty ||
        request.address.isEmpty ||
        request.phone.isEmpty ||
        request.password.isEmpty ||
        request.confirmPassword.isEmpty) {
      return {
        'success': false,
        'message': 'Vui lòng điền đầy đủ thông tin',
      };
    }

    if (request.password != request.confirmPassword) {
      return {
        'success': false,
        'message': 'Mật khẩu không khớp',
      };
    }

    final phoneRegex = RegExp(r"^(0[3|5|7|8|9])+([0-9]{8})$");
    if (!phoneRegex.hasMatch(request.phone)) {
      return {
        'success': false,
        'message': 'Số điện thoại không hợp lệ',
      };
    }

    final url = Uri.parse("$baseUrl/register/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'success': true,
      };
    } else {
      return {
        'success': false,
        'message': 'Đăng ký thất bại. Vui lòng thử lại.',
      };
    }
  }

  Future<void> saveUserToLocal(LoginResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
  }
}
