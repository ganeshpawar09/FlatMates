import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flutter/material.dart';

class ChatDetailPageCard extends StatelessWidget {
  final String message;
  final bool isUserMessage;
  const ChatDetailPageCard(
      {super.key, required this.message, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUserMessage ? customYellow : Colors.black54,
          borderRadius: BorderRadius.only(
              bottomLeft: (isUserMessage) ? Radius.circular(10) : Radius.zero,
              bottomRight: (isUserMessage) ? Radius.zero : Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10)),
        ),
        child: Text(
          message,
          style: AppStyles.mondaN.copyWith(
            color: (isUserMessage) ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
