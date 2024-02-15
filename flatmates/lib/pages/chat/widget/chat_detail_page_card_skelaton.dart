import 'package:flatmates/widget/skelaton_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatDetailPageCardSkelaton extends StatelessWidget {
  const ChatDetailPageCardSkelaton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                SkelatonWidget(height: 40, width: 180),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SkelatonWidget(height: 40, width: 180),
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
