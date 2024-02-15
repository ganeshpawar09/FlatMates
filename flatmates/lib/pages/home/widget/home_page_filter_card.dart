import 'package:flatmates/const/font.dart';
import 'package:flutter/material.dart';

class HomePageFilterCard extends StatelessWidget {
  final String title;
  const HomePageFilterCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
      padding: const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      child: InkWell(
        onTap: () {},
        child: Center(
            child: Text(
          title,
          style: AppStyles.mondaB.copyWith(fontSize: 14),
        )),
      ),
    );
  }
}
