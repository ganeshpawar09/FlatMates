import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flatmates/pages/chat/chat_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ChatPageCard extends StatelessWidget {
  final Chat chat;
  const ChatPageCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final name = chat.name;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: customYellow,
        child: Text(
          name.substring(0, 1),
          style: AppStyles.mondaB.copyWith(fontSize: 20, color: Colors.black),
        ),
      ),
      title: Text(name,
          style: AppStyles.mondaB.copyWith(fontSize: 18, color: Colors.black)),
      trailing: Icon(
        UniconsLine.angle_right,
        color: customYellow,
        size: 35,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              chat: chat,
            ),
          ),
        );
      },
    );
  }
}
