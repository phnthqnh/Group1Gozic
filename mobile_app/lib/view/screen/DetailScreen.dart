import 'package:flutter/material.dart';
import 'package:mobile_app/controller/ProductController.dart';
import 'package:mobile_app/utils/AppUtils.dart';

import '../../model/response/ProductResponse.dart';
import '../widget/PromoItem.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final url = "http://10.0.2.2:8000/api/";
  final ProductController productController = ProductController();
  final defaultImage =
      "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=";
  bool _isLoading = true;
  String? _error;
  ProductResponse? _product;
  @override
  void initState() {
    super.initState();
    _fetchProductDetail();
  }

  void _fetchProductDetail() async {
    try {
      final product = await productController.getProductById(widget.id);
      setState(() {
        _product = product;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.white,
        child: Container(
          color: Colors.white,
          height: 80,
          child: Row(
            children: [
              Column(
                children: [
                  IconButton(icon: Icon(Icons.chat), onPressed: () {}),
                  Text("Chat"),
                ],
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  IconButton(icon: Icon(Icons.phone), onPressed: () {}),
                  Text("Liên hệ"),
                ],
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(200, double.infinity),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},

                child: Text(
                  'Mua hàng',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
        ? Center(child: CircularProgressIndicator())
          : _error != null
        ?Center(child: Text("Lỗi: $_error"))
          :_product == null
        ?Center(child: Text("Không tìm thấy sản phẩm"))
          :SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: PageView(
                    children: [
                      Image.network(
                        _product?.image != null && _product!.image.isNotEmpty
                            ? url + _product!.image
                            : defaultImage,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            defaultImage,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.black.withOpacity(0.3),
                      ),
                    ),
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 16,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.black.withOpacity(0.3),
                          ),
                        ),
                        icon: Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.black.withOpacity(0.3),
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.share, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Tên sản phẩm + giá
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _product!.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    AppUtils().formatCurrency(
                        double.tryParse(_product!.price.toString()) ?? 0
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Khuyến mãi
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PromoItem(text: 'Miễn phí ship đơn hàng trên 500K'),
                          PromoItem(text: 'Đổi trả hàng trong vòng 7 ngày'),
                          PromoItem(text: 'Cam kết hàng chính hãng'),
                          PromoItem(text: 'Đền 300% nếu hàng không rõ xuất xứ'),
                          PromoItem(text: 'Ship hàng trên toàn quốc'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/image/notfound.jpg",
                            width: 100,
                            height: 100,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent,
                              minimumSize: Size(70, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {},

                            child: Text(
                              'Vị trí',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //chi tiet san pham
                  SizedBox(height: 15,),
                  Text(
                    "Chi tiết sản phẩm",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    _product!.description,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),

                ],
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
