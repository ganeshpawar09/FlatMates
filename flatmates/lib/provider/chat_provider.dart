import 'dart:convert';

import 'package:flatmates/const/constant.dart';
import 'package:flatmates/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider extends ChangeNotifier {
  List<Chat> chatList = [];
  bool chatListFetched = false;

  Future<void> fetchChat(bool refresh) async {
    try {
      if (refresh) {
        notifyListeners();
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final url = "$server/chat/fetch-room";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
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

      if (response.statusCode == 200) {
        List<Chat> temp = [];
        for (var element in data['data']) {
          Chat chat = Chat.fromJson(element);
          temp.add(chat);
        }
        chatList = temp;
        chatListFetched = true;
        notifyListeners();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Something went wrong while loading chat $e");
      return;
    }
  }
}
