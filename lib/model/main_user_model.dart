import 'package:flutter/material.dart';

class MainUserModel {
  final int age;
  final String id;
  final String name;
  final String location;
  final double distanceKm;
  final String profession;
  final IconData? locationIcon;
  final List<String> imageUrls;

  MainUserModel({
    required this.id,
    required this.age,
    required this.name,
    required this.location,
    required this.imageUrls,
    required this.distanceKm,
    required this.profession,
    this.locationIcon = Icons.location_on,
  });

  factory MainUserModel.fromJson(Map<String, dynamic> json) {
    return MainUserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      location: json['location'] ?? '',
      distanceKm: (json['distanceKm'] ?? 0.0).toDouble(),
      profession: json['profession'] ?? '',
      locationIcon: IconData(
        json['locationIcon'] ?? Icons.location_on.codePoint,
        fontFamily: 'MaterialIcons',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'imageUrls': imageUrls,
      'location': location,
      'distanceKm': distanceKm,
      'profession': profession,
      'locationIcon': locationIcon?.codePoint,
    };
  }
}