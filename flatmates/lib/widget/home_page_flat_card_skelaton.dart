import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePageFlatCardSkelaton extends StatelessWidget {
  const HomePageFlatCardSkelaton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, bottom: 10),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerContainer(180, double.infinity),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerContainer(30, 250),
                    SizedBox(
                      height: 8,
                    ),
                    _buildShimmerContainer(30, 150),
                    SizedBox(
                      height: 3,
                    ),
                    _buildShimmerContainer(30, 180),
                    SizedBox(
                      height: 3,
                    ),
                    _buildShimmerContainer(30, 230),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildShimmerContainer(40, 150),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    )
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

Widget _buildShimmerContainer(double height, double width) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.white,
    period: const Duration(milliseconds: 2000),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade300,
      ),
    ),
  );
}
