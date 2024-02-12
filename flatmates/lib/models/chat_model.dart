class Chat {
  String id;
  String name;
  String customId;
  List<Message> messages;
  String lastmessage;

  Chat({
    required this.id,
    required this.name,
    required this.customId,
    required this.messages,
    required this.lastmessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    var messagesList = json['messages'] as List;
    List<Message> messages =
        messagesList.map((message) => Message.fromJson(message)).toList();

    return Chat(
      id: json['_id'],
      name: json['name'],
      customId: json['customId'],
      messages: messages,
      lastmessage: json['lastmessage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': this.id,
      'name': this.name,
      'customId': this.customId,
      'messages': this.messages.map((message) => message.toJson()).toList(),
      'lastmessage': this.lastmessage,
    };
    return data;
  }
}

class Message {
  String id;
  String sender;
  String content;

  Message({
    required this.id,
    required this.sender,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: json['sender'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': this.id,
      'sender': this.sender,
      'content': this.content,
    };
    return data;
  }
}
