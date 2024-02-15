import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flatmates/models/message_model.dart';
import 'package:flatmates/pages/chat/widget/chat_detail_page_card.dart';
import 'package:flatmates/pages/chat/widget/chat_detail_page_card_skelaton.dart';
import 'package:flatmates/provider/chat_provider.dart';
import 'package:flatmates/provider/socket_io.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailPage extends StatefulWidget {
  final Chat chat;
  const ChatDetailPage({super.key, required this.chat});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _message = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Future<void> fetch() async {
    String chatId = widget.chat.id;
    await Provider.of<ChatProvider>(context, listen: false)
        .fetchMessage(false, chatId);
  }

  void sendMessage() async {
    String content = _message.text;
    if (content.isEmpty) {
      SnackBar snackBar = const SnackBar(content: Text("Message is empty"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    await Provider.of<SocketIo>(context, listen: false)
        .sendMessageToSocket(context, _message.text, widget.chat.id);

    _message.text = "";
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ChatDetailPageCardSkelaton();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<ChatProvider>(
              builder: (context, value, child) {
                List<Message> message = value.messageList;
                String userId = value.userIdFor;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: message.length,
                        itemBuilder: (context, index) {
                          return ChatDetailPageCard(
                              message: message[index].content,
                              isUserMessage: message[index].sender == userId);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildMessageInput(),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/error.png",
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 10),
                    child: Text(
                      "There is no data",
                      textAlign: TextAlign.center,
                      style: AppStyles.mondaB.copyWith(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: customYellow,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        minimumSize: const Size(200, 40)),
                    onPressed: () {
                      fetch();
                    },
                    child: Text(
                      "Refresh",
                      style: AppStyles.mondaB.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 5),
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
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "Type your message....",
                hintStyle: AppStyles.mondaN.copyWith(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: Icon(
              Icons.send,
              color: customYellow,
            ),
            onPressed: () {
              sendMessage();
            },
          ),
        ],
      ),
    );
  }
}
