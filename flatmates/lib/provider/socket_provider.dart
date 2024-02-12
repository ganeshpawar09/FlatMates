import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends ChangeNotifier {
  IO.Socket? socket = null;
  bool isConnected = false;

  Future<bool> connectToSocket() async {
    try {
      socket = IO.io('https://flatmates.onrender.com/');
      if (socket != null) {
        socket!.onConnect((_) {
          print('Connected to socket');
          // socket.emit('msg', 'test');
          return true;
        });

        socket!.onDisconnect((_) {
          print('Disconnected from socket');
        });

        socket!.onError((error) {
          print('Socket error: $error');
        });
      }

      return false;
    } catch (e) {
      print("Something went wrong while socket connecting. Error: $e");
      return false;
    }
  }
}
