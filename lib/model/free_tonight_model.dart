class FreeTonightModel {
  final int age;
  final String name;
  final String image;
  final double distance;
  final String location;
  final String profession;

  FreeTonightModel({
    required this.age,
    required this.name,
    required this.image,
    required this.distance,
    required this.location,
    required this.profession,
  });

  factory FreeTonightModel.fromJson(Map<String, dynamic> json) {
    return FreeTonightModel(
      name: json['name'] ?? '',
      profession: json['profession'] ?? '',
      age: json['age'] ?? 0,
      distance: (json['distance'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      location: json['location'] ?? '',
    );
  }
}