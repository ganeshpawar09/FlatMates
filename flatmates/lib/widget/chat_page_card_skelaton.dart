import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatPageCardSkelaton extends StatelessWidget {
  const ChatPageCardSkelaton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildShimmerContainer(40, 40),
      title: _buildShimmerContainer(30, 100),
      trailing: _buildShimmerContainer(35, 35),
    );
  }
}

Widget _buildShimmerContainer(double height, double width) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Shimmer.fromColors(
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
      ),
      const SizedBox(
        height: 3,
      )
    ],
  );
}
