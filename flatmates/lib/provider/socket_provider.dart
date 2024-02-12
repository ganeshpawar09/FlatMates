import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends ChangeNotifier {
  IO.Socket? socket;
  bool isConnected = false;

  Future<bool> connectToSocket() async {
    try {
      socket = IO.io('https://flatmates.onrender.com/', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      if (socket != null) {
        await socket!.connect();
      }
      socket!.onConnect((_) {
        print('Connected to server');
        print('Socket ID: ${socket!.id}');
      });

      return false;
    } catch (e) {
      print("Something went wrong while socket connecting. Error: $e");
      return false;
    }
  }

  Future<void> disconnectToSocket() async {
    try {
      if (socket != null) {
        await socket!.disconnect();
      }

      socket!.onDisconnect((_) {
        print('Disconnected from server');
      });
    } catch (e) {
      print("Something went wrong while socket disconnecting. Error: $e");
    }
  }
}
