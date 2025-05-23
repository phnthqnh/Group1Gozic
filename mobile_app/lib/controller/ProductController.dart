import 'dart:convert';

import '../model/response/ProductResponse.dart';
import 'package:http/http.dart' as http;
class ProductController{
  final String baseUrl = "http://10.0.2.2:8000/api";
  //lay danh sach product
  Future<List<ProductResponse>> getListProduct() async {
    final url = Uri.parse("$baseUrl/products/");
    try{
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept-Charset': 'utf-8',
        },
      );
      if(response.statusCode == 200){
          final body = utf8.decode(response.bodyBytes);
          final List data = jsonDecode(body);
          return data.map((e) => ProductResponse.fromJson(e)).toList();
      }else{
        throw Exception("Lỗi lấy danh sách product");
      }
    }catch(e){
      throw Exception("Error: $e");
    }
  }

  //lay product theo id
  Future<ProductResponse> getProductById(int id) async {
    final url = Uri.parse("$baseUrl/products/$id/");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept-Charset': 'utf-8',
        },
      );
      if(response.statusCode == 200){
        final body = utf8.decode(response.bodyBytes);
        return ProductResponse.fromJson(jsonDecode(body));
      }else{
        throw Exception("Lỗi lấy product theo id");
      }
    }catch(e){
      throw Exception("Error: $e");
    }
  }


}