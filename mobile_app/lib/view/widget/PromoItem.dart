import 'package:flutter/material.dart';

class PromoItem extends StatefulWidget {
  final String text;
  const PromoItem({super.key, required this.text});


  @override
  State<PromoItem> createState() => _PromoItemState();
}

class _PromoItemState extends State<PromoItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'HOT!',
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(widget.text, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
