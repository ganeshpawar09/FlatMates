import 'package:flatmates/models/message_model.dart';
import 'package:flatmates/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIo extends ChangeNotifier {
  IO.Socket? socket;

  Future<void> initializeSocket(BuildContext context) async {
    socket = IO.io('https://flatmates.onrender.com/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    if (socket != null) {
      connectToSocket(context);
    }
  }

  Future<void> connectToSocket(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString("userId");

    try {
      await socket!.connect();

      socket!.onConnect((_) {
        print('Socket connected. ID: ${socket!.id}');

        print('Socket connected successfully.');
        socket!.emit("user_connect", {'userId': userId});
        socket!.on("newMessage", (data) async {
          print('New message received: $data');

          Message message = Message.fromJson(data);

          Provider.of<ChatProvider>(context, listen: false).addMessage(message);
          print("hello");
        });
      });
    } catch (e) {
      print('Error connecting to socket: $e');
    }
  }

  Future<void> sendMessageToSocket(
      BuildContext context, String content, String chatId) async {
    try {
      if (content.isEmpty) {
        SnackBar snackBar = const SnackBar(content: Text("Message is empty"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? senderId = preferences.getString("userId");
      print(senderId);
      print(chatId);
      print(content);
      socket!.emit("sendMessage", {
        "senderId": senderId,
        "chatId": chatId,
        "content": content,
      });
    } catch (e) {
      print("something went wrong");
    }
  }
}
