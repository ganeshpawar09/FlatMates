import 'dart:convert';

import 'package:flatmates/const/constant.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flatmates/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider extends ChangeNotifier {
  List<Chat> chatList = [];
  bool chatListFetched = false;
  List<Message> messageList = [];
  bool messageListFetched = false;
  String userIdFor = "";

  Future<void> fetchChat(bool refresh) async {
    try {
      if (refresh) {
        chatList = [];
        notifyListeners();
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      const url = "$server/chat/fetch-chat";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      String? userName = await pref.getString("userName");
      if (accessToken == null) {
        return;
      }
      String id =
          preferences.getString("userId").toString().replaceAll('"', '');
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": accessToken, "userId": id},
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        List<Chat> temp = [];
        for (var element in data['data']) {
          Chat chat = Chat.fromJson(element);
          if (userName != null) {
            chat.name = chat.name
                .toString()
                .replaceAll(" and ", "")
                .replaceAll(userName, "");
          }
          userIdFor = id;
          temp.add(chat);
        }
        chatList = temp;
        chatListFetched = true;
        notifyListeners();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Something went wrong while loading data $e");
      return;
    }
  }

  Future<void> addMessage(Message message) async {
    messageList.add(message);
    print('Updated message: $message');
    notifyListeners();
    return;
  }

  Future<void> fetchMessage(bool refresh, String chatId) async {
    try {
      if (refresh) {
        chatList = [];
        notifyListeners();
      }
      final url = "$server/chat/fetch-message";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      if (accessToken == null) {
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": accessToken, "chatId": chatId},
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        List<Message> temp = [];
        for (var element in data['data']) {
          Message message = Message.fromJson(element);
          temp.add(message);
        }
        messageList = temp;
        messageListFetched = true;
        notifyListeners();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Something went wrong while loading data $e");
      return;
    }
  }

  Future<bool> sendMessage(String chatId, String content) async {
    try {
      const url = "$server/chat/send-message";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      String? userId = await pref.getString("userId");
      if (accessToken == null) {
        return false;
      }

      final response = await http.post(Uri.parse(url), headers: {
        "Authorization": accessToken,
      }, body: {
        "chatId": chatId,
        "senderId": userId,
        "content": content
      });
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        Message message = Message.fromJson(data['data']);

        messageList.add(message);
        notifyListeners();
        return true;
      } else {
        print("Something went wrong");
        return false;
      }
    } catch (e) {
      print("Something went wrong while loading data $e");
      return false;
    }
  }

  Future<Chat?> createNewChat(String ownerId, String flatId) async {
    try {
      const url = "$server/chat/create-chat";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      String? userId = await pref.getString("userId");
      if (accessToken == null) {
        return null;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": accessToken,
        },
        body: {
          "userId": userId,
          "ownerId": ownerId,
          "flatId": flatId,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        if (data['data'] != null) {
          Chat chat = Chat.fromJson(data['data']);
          return chat;
        } else {
          print("Data from server is null");
          return null;
        }
      } else {
        print(
            "Something went wrong with the server. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Something went wrong while loading data $e");
      return null;
    }
  }
}
