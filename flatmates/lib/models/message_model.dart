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
