import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatInsidePage extends StatelessWidget {
  final Chat chat;
  const ChatInsidePage({super.key, required this.chat});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          chat.name,
          style: AppStyles.mondaB.copyWith(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chat.messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                bool isUserMessage = index % 2 == 0;

                return chatChard(
                  'This is messsdfdsdfsdfsdage $index',
                  isUserMessage,
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildMessageInput()
        ],
      ),
    );
  }
}

Widget _buildMessageInput() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Colors.black54,
              style: AppStyles.mondaB.copyWith(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "Type your message....",
                hintStyle: AppStyles.mondaN.copyWith(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(
              Icons.send,
              color: customYellow,
            ),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}

Widget chatChard(
  String message,
  bool isUserMessage,
) {
  return Align(
    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      width: 180,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
