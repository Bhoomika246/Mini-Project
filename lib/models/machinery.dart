class Machinery {
  final int id;
  final String name;
  final String type;
  final String power;
  final double price;
  final double rating;
  final String image;
  final String location;
  final String address;
  final double distance;
  final String owner;
  final String phone;
  final List<String> suitable;
  final String demand;
  final List<String> soilSuitability;

  Machinery({
    required this.id,
    required this.name,
    required this.type,
    required this.power,
    required this.price,
    required this.rating,
    required this.image,
    required this.location,
    required this.address,
    required this.distance,
    required this.owner,
    required this.phone,
    required this.suitable,
    required this.demand,
    required this.soilSuitability,
  });

  factory Machinery.fromJson(Map<String, dynamic> json) {
    return Machinery(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      power: json['power'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      address: json['address'] ?? '',
      distance: (json['distance'] ?? 0).toDouble(),
      owner: json['owner'] ?? '',
      phone: json['phone'] ?? '',
      suitable: List<String>.from(json['suitable'] ?? []),
      demand: json['demand'] ?? '',
      soilSuitability: List<String>.from(json['soil_suitability'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'power': power,
      'price': price,
      'rating': rating,
      'image': image,
      'location': location,
      'address': address,
      'distance': distance,
      'owner': owner,
      'phone': phone,
      'suitable': suitable,
      'demand': demand,
      'soil_suitability': soilSuitability,
    };
  }
}
