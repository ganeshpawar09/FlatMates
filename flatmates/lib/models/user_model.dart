class User {
  String id;
  String name;
  String phoneNumber;
  List<String> favouriteFlats;
  List<String> ownFlats;
  String accessToken;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.favouriteFlats,
    required this.ownFlats,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      favouriteFlats: List<String>.from(json['favouriteFlats']),
      ownFlats: List<String>.from(json['ownFlats']),
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'favouriteFlats': favouriteFlats,
      'ownFlats': ownFlats,
      'accessToken': accessToken,
    };
  }
}
