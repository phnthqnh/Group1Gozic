import 'package:flutter/material.dart';
import 'package:mobile_app/controller/CategoryController.dart';
import 'package:mobile_app/model/response/CategoryResponse.dart';
import 'package:mobile_app/model/response/ProductResponse.dart';
import 'package:mobile_app/view/widget/ProductItem.dart';

import '../../controller/ProductController.dart';
import '../widget/CategoryItem.dart';

class HomeScreen extends StatefulWidget {
  final CategoryController categoryController = CategoryController();
  final ProductController productController = ProductController();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  List<CategoryResponse> _categories = [];
  List<ProductResponse> _products = [];
  bool _isLoading = true;

  Future<void> _fetchData() async {
    try {
      final categories = await widget.categoryController.getListCategory();
      final products = await widget.productController.getListProduct();

      setState(() {
        _categories = categories;
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
      setState(() => _isLoading = false);
    }
  }

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
          padding: const EdgeInsets.only(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Colors.red,
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 15,
                  right: 15,
                  bottom: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                        ),
                        Text(
                          "Welcome",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart_outlined),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm sản phẩm",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //noi dung
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),

                      //Banner
                      SizedBox(
                        height: 200,
                        child: PageView(
                          children: [
                            Image.asset(
                              "assets/image/banner_1.webp",
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              "assets/image/banner_2.jpg",
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              "assets/image/banner_3.jpg",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              return CategoryItem(category: category);
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dành cho bạn",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8), // 👈 Điều chỉnh khoảng cách tại đây
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio: (MediaQuery.of(context).size.width * 0.4) / 230,
                              children: _products.map((product) {
                                return ProductItem(product: product);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
