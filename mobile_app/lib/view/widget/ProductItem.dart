import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {

  final String image;

  const ProductItem({super.key, required this.image});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(widget.image), fit: BoxFit.cover),
      ),
    );
  }
}
