import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/pages/chat/chat_inside_page.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: customYellow,
              child: Text(
                "G",
                style: AppStyles.mondaB
                    .copyWith(fontSize: 20, color: Colors.black),
              ),
            ),
            title: Text("Ganesh",
                style: AppStyles.mondaB
                    .copyWith(fontSize: 18, color: Colors.black)),
            subtitle: Text('Last message...',
                style: AppStyles.mondaN
                    .copyWith(fontSize: 14, color: Colors.black87)),
            trailing: Icon(
              UniconsLine.angle_right,
              color: customYellow,
              size: 35,
            ),
            isThreeLine: true,
            
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatInsidePage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
