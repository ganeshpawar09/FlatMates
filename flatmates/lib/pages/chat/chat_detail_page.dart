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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatDetailPage extends StatefulWidget {
  final Chat chat;
  const ChatDetailPage({super.key, required this.chat});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _message = TextEditingController();

  // IO.Socket? socket;
  // void send() async {
  //   String content = _message.text;
  //   if (content.isEmpty) {
  //     SnackBar snackBar = const SnackBar(content: Text("Message is empty"));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     return;
  //   }
  //   bool send = await Provider.of<ChatProvider>(context, listen: false)
  //       .sendMessage(widget.chat.id, content);

  //   if (!send) {
  //     SnackBar snackBar = const SnackBar(content: Text("Something went wrong"));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  //   _message.text = "";
  // }

  Future<void> fetch() async {
    String chatId = widget.chat.id;
    await Provider.of<ChatProvider>(context, listen: false)
        .fetchMessage(false, chatId);
  }

  // void connectToSocket() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? userId = preferences.getString("userId");

  //   try {
  //     await socket!.connect();

  //     socket!.onConnect((_) {
  //       print('Socket connected. ID: ${socket!.id}');

  //       print('Socket connected successfully.');
  //       socket!
  //           .emit("user_connect", {'userId': userId, 'chatId': widget.chat.id});
  //       socket!.on("newMessage", (data) async {
  //         print('New message received: $data');

  //         Message message = Message.fromJson(data);

  //         Provider.of<ChatProvider>(context, listen: false).addMessage(message);
  //         print("hello");
  //       });
  //     });
  //   } catch (e) {
  //     print('Error connecting to socket: $e');
  //   }
  // }

  // void sendMessageToSocket() async {
  //   String content = _message.text;
  //   if (content.isEmpty) {
  //     SnackBar snackBar = const SnackBar(content: Text("Message is empty"));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     return;
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? senderId = preferences.getString("userId");
  //   String chatId = widget.chat.id;
  //   print(senderId);
  //   print(chatId);
  //   print(content);
  //   socket!.emit("sendMessage", {
  //     "senderId": senderId,
  //     "chatId": chatId,
  //     "content": content,
  //   });

  //   _message.text = "";
  // }
  void sendMessageToSocket() async {
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
  void initState() {
    super.initState();

    // socket = IO.io('https://flatmates.onrender.com/', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    // });
    // if (socket != null) {
    //   connectToSocket();
    // }
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
                String userId = value.userIdFor;
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
              },
            );
          } else {
            return const ChatDetailPageCardSkelaton();
          }
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.only(
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
              sendMessageToSocket();
            },
          ),
        ],
      ),
    );
  }
}
