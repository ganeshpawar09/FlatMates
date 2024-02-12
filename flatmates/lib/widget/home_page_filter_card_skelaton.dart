import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePageFilterCardSkelaton extends StatelessWidget {
  const HomePageFilterCardSkelaton({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildShimmerContainer(40, 100);
  }
}

Widget _buildShimmerContainer(double height, double width) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.white,
    period: const Duration(milliseconds: 2000),
    child: Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(left: 8, top: 5, bottom: 5),
      padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
    ),
  );
}
