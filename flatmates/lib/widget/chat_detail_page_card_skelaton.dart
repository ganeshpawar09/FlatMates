import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatDetailPageCardSkelaton extends StatelessWidget {
  const ChatDetailPageCardSkelaton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                _buildShimmerContainer(40, 180),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildShimmerContainer(40, 180),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}

Widget _buildShimmerContainer(double height, double width) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
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
