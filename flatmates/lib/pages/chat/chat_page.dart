import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flatmates/pages/chat/widget/chat_page_card.dart';
import 'package:flatmates/pages/chat/widget/chat_page_card_skelaton.dart';
import 'package:flatmates/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void showSnackBarOnPage(String content) {
    SnackBar snackBar = SnackBar(content: Text(content));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isRefreshing = false;

  Future<void> fetch(bool isRefresh) async {
    try {
      if (isRefresh) {
        await Provider.of<ChatProvider>(context, listen: false).fetchChat(true);
      } else {
        if (!Provider.of<ChatProvider>(context, listen: false)
            .chatListFetched) {
          await Provider.of<ChatProvider>(context, listen: false)
              .fetchChat(false);
        }
      }
    } catch (e) {
      showSnackBarOnPage("Something went wrong while fetching chats");
    }
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
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          setState(() {
            isRefreshing = true;
          });
          await fetch(true);
          setState(() {
            isRefreshing = false;
          });
        },
        child: FutureBuilder<void>(
          future: fetch(false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                isRefreshing) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ChatPageCardSkelaton();
                },
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<ChatProvider>(
                builder: (context, value, child) {
                  List<Chat> chat = value.chatList;
                  if (chat.isEmpty) {
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
                              fetch(true);
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
                  } else {
                    return ListView.builder(
                      itemCount: chat.length,
                      itemBuilder: (context, index) {
                        return ChatPageCard(chat: chat[index]);
                      },
                    );
                  }
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
                        fetch(true);
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
      ),
    );
  }
}
