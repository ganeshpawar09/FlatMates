import 'package:flutter/material.dart';

class HomePageFilterCardSkelaton extends StatelessWidget {
  const HomePageFilterCardSkelaton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      margin: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
      padding: const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.shade300),
    );
  }
}
