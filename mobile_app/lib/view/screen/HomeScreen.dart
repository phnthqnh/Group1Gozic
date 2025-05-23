import 'package:flutter/material.dart';

import '../widget/CategoryItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            CategoryItem(
                              label: "Đồ Nam",
                              image: "assets/image/donam.jpg",
                            ),
                            CategoryItem(
                              label: "Đồ Nữ",
                              image: "assets/image/donu.jpg",
                            ),
                            CategoryItem(
                              label: "Đồ Trẻ Em",
                              image: "assets/image/dotreem.jpg",
                            ),
                            CategoryItem(
                              label: "Phụ Kiện",
                              image: "assets/image/phukien.jpg",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Dành cho bạn",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      // Danh sách sản phẩm gợi ý
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            // _ProductItem(image: "assets/product1.png"),
                            // _ProductItem(image: "assets/product2.png"),
                            // _ProductItem(image: "assets/product3.png"),
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
