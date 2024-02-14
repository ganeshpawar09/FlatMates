class Message {
  final String sender;
  final String content;
  final String id;

  Message({
    required this.sender,
    required this.content,
    required this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      content: json['content'],
      id: json['_id'],
    );
  }
}
