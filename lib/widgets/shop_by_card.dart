import 'package:flutter/material.dart';
import 'package:mobilicis/constents/app_sized_boxes.dart';

class ShopByCard extends StatelessWidget {
  const ShopByCard({super.key, required this.text, required this.img});

  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Image.asset(img),
          ),
          AppSizedBoxes.h10,
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
