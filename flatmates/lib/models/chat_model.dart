class Chat {
  String id;
  String name;
  String customId;
  String flat;
  String lastmessage;

  Chat({
    required this.id,
    required this.name,
    required this.flat,
    required this.customId,
    required this.lastmessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      flat: json['flat'] ?? '',
      customId: json['customId'] ?? '',
      lastmessage: json['lastmessage'] ?? '',
    );
  }
}
