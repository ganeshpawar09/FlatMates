class Flat {
  String id;
  String ownerId;
  List<String> flatPhotos;
  String buildingName;
  String address;
  String city;
  String state;
  String pinCode;
  String landmark;
  String description;
  int rent;
  String apartmentType;
  String furnish;
  String waterSupply;
  bool galleryAvailable;
  bool parkingAvailable;
  bool cctvAvailable;
  bool securityAvailable;
  int currentFlatmates;
  int flatmatesNeeded;
  String flatmatePreference;
  DateTime createdAt;
  DateTime updatedAt;
  bool favourite;
  Flat({
    required this.favourite,
    required this.id,
    required this.ownerId,
    required this.flatPhotos,
    required this.buildingName,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.landmark,
    required this.description,
    required this.rent,
    required this.apartmentType,
    required this.furnish,
    required this.waterSupply,
    required this.galleryAvailable,
    required this.parkingAvailable,
    required this.cctvAvailable,
    required this.securityAvailable,
    required this.currentFlatmates,
    required this.flatmatesNeeded,
    required this.flatmatePreference,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Flat.fromJson(Map<String, dynamic> json) {
    return Flat(
      id: json['_id'],
      favourite: json['favourite'],
      ownerId: json['ownerId'],
      flatPhotos: List<String>.from(json['flatPhotos']),
      buildingName: json['buildingName'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pinCode: json['pinCode'],
      landmark: json['landmark'],
      description: json['description'],
      rent: json['rent'],
      apartmentType: json['apartmentType'],
      furnish: json['furnish'],
      waterSupply: json['waterSupply'],
      galleryAvailable: json['galleryAvailable'],
      parkingAvailable: json['parkingAvailable'],
      cctvAvailable: json['cctvAvailable'],
      securityAvailable: json['securityAvailable'],
      currentFlatmates: json['currentFlatmates'],
      flatmatesNeeded: json['flatmatesNeeded'],
      flatmatePreference: json['flatmatePreference'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'favourite': favourite,
      'ownerId': ownerId,
      'flatPhotos': flatPhotos,
      'buildingName': buildingName,
      'address': address,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'landmark': landmark,
      'description': description,
      'rent': rent,
      'apartmentType': apartmentType,
      'furnish': furnish,
      'waterSupply': waterSupply,
      'galleryAvailable': galleryAvailable,
      'parkingAvailable': parkingAvailable,
      'cctvAvailable': cctvAvailable,
      'securityAvailable': securityAvailable,
      'currentFlatmates': currentFlatmates,
      'flatmatesNeeded': flatmatesNeeded,
      'flatmatePreference': flatmatePreference,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
