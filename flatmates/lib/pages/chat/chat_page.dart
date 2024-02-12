import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flatmates/provider/chat_provider.dart';
import 'package:flatmates/widget/chat_page_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Chats",
          style: AppStyles.mondaB.copyWith(fontSize: 25, color: Colors.black),
        ),
      ),
      body: Consumer<ChatProvider>(
        builder: (context, value, child) {
          List<Chat> chat = value.chatList;
          if (chat.isEmpty) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: customYellow,
                    child: Text(
                      "..",
                      style: AppStyles.mondaB
                          .copyWith(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  title: Text("...",
                      style: AppStyles.mondaB
                          .copyWith(fontSize: 18, color: Colors.black)),
                  subtitle: Text('...',
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 14, color: Colors.black87)),
                  trailing: Icon(
                    UniconsLine.angle_right,
                    color: customYellow,
                    size: 35,
                  ),
                  isThreeLine: true,
                );
              },
            );
          } else {
            return ListView.builder(
              itemCount: chat.length,
              itemBuilder: (context, index) {
                return ChatPageCard(chat: chat[index]);
              },
            );
          }
        },
      ),
    );
  }
}
