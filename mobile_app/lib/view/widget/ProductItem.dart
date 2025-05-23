import 'package:flutter/material.dart';
import 'package:mobile_app/model/response/ProductResponse.dart';
import 'package:mobile_app/routers/app_routes.dart';
import 'package:mobile_app/utils/AppUtils.dart';

class ProductItem extends StatefulWidget {
  final ProductResponse product;

  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final url = "http://10.0.2.2:8000/api/";
  final defaultImage =
      "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=";

  // ví dụ chiếm 40%
  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width; // lấy chiều rộng màn hình
    final itemWidth = screenWidth * 0.4;
    return SizedBox(
      width: itemWidth,
      height: 200,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.productDetail, arguments: widget.product.id);
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  widget.product.image != null && widget.product.image.isNotEmpty
                      ? url + widget.product.image
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      widget.product.name,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.product.category_name,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      AppUtils().formatCurrency(
                        double.tryParse(widget.product.price.toString()) ?? 0,
                      ),
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
