import 'package:flatmates/widget/skelaton_widget.dart';
import 'package:flutter/material.dart';

class ChatPageCardSkelaton extends StatelessWidget {
  const ChatPageCardSkelaton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: SkelatonWidget(height: 40, width: 40),
      title: SkelatonWidget(height: 30, width: 100),
      trailing: SkelatonWidget(height: 35, width: 35),
    );
  }
}
