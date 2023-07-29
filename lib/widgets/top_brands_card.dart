import 'package:flutter/material.dart';

class TopBrandsCard extends StatelessWidget {
  const TopBrandsCard({
    super.key,
    required this.logo,
  });

  final String logo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 70,
        child: Image.asset(logo),
      ),
    );
  }
}
