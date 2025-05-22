import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  final String label;
  final String image;

  const CategoryItem({super.key, required this.label, required this.image});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(widget.image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(widget.label),
        ],
      ),
    );
  }
}
