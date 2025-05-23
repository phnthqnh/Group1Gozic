import 'package:flutter/material.dart';
import 'package:mobile_app/model/response/CategoryResponse.dart';

class CategoryItem extends StatefulWidget {
  final CategoryResponse category;

  const CategoryItem({super.key, required this.category});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 50,
        width: 100,
        child: Card(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(widget.category.name, style: TextStyle())),
        ),
      ),
    );
  }
}
