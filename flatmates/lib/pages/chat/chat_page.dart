import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flatmates/provider/chat_provider.dart';
import 'package:flatmates/widget/chat_page_card.dart';
import 'package:flatmates/widget/chat_page_card_skelaton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    
    if (!Provider.of<ChatProvider>(context, listen: false).chatListFetched)
      Provider.of<ChatProvider>(context, listen: false).fetchChat(false);
  }

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
                return ChatPageCardSkelaton();
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
