import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flatmates/models/message_model.dart';
import 'package:flatmates/provider/chat_provider.dart';
import 'package:flatmates/widget/chat_detail_page_card.dart';
import 'package:flatmates/widget/chat_detail_page_card_skelaton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailPage extends StatefulWidget {
  final Chat chat;
  const ChatDetailPage({super.key, required this.chat});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _message = TextEditingController();
  void send() async {
    String content = _message.text;
    if (content.isEmpty) {
      SnackBar snackBar = SnackBar(content: Text("Message is empty"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    bool send = await Provider.of<ChatProvider>(context, listen: false)
        .sendMessage(widget.chat.id, content);

    if (!send) {
      SnackBar snackBar = SnackBar(content: Text("Something went wrong"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    _message.text = "";
  }

  Future<void> fetch() async {
    String chatId = widget.chat.id;
    await Provider.of<ChatProvider>(context, listen: false)
        .fetchMessage(false, chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.chat.name,
          style: AppStyles.mondaB.copyWith(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<ChatProvider>(
              builder: (context, value, child) {
                List<Message> message = value.messageList;
                String userId = value.userId;
                if (message.isEmpty) {
                  return ChatDetailPageCardSkelaton();
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: message.length,
                          itemBuilder: (context, index) {
                            return ChatDetailPageCard(
                                message: message[index].content,
                                isUserMessage: message[index].sender == userId);
                          },
                        ),
                      ),
                      _buildMessageInput(),
                    ],
                  );
                }
              },
            );
          } else {
            // Return a loading indicator or placeholder while waiting for data
            return ChatDetailPageCardSkelaton();
          }
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 10,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _message,
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
            onPressed: () {
              send();
            },
          ),
        ],
      ),
    );
  }
}