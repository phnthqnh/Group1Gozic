import 'dart:convert';

import 'package:mobile_app/model/response/CategoryResponse.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/model/response/ProductResponse.dart';

class CategoryController {
  final String baseUrl = "http://10.0.2.2:8000/api";

  //lay danh sach cetegory
  Future<List<CategoryResponse>> getListCategory() async {
    final url = Uri.parse("$baseUrl/categories/");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept-Charset': 'utf-8',
        },
      );
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final List data = jsonDecode(body);
        return data.map((e) => CategoryResponse.fromJson(e)).toList();
      } else {
        throw Exception("Lỗi lấy danh sách category");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
