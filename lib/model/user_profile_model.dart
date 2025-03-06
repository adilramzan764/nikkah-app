class UserProfileModel {
  int age;
  String name;
  String? bio;
  String? born;
  String? city;
  String? drink;
  String? gender;
  String? height;
  String? workout;
  String? country;
  String? interest;
  String? starSign;
  String? birthday;
  String? jobTitle;
  String? religion;
  String? lifestyle;
  String? community;
  String? intentions;
  String? personality;
  String? description;
  String? profileImage;
  String? educationLevel;
  List<String> languages;
  String subscriptionType;
  List<String> galleryImages;

  UserProfileModel({
    this.bio,
    this.city,
    this.born,
    this.drink,
    this.height,
    this.gender,
    this.country,
    this.workout,
    this.jobTitle,
    this.birthday,
    this.religion,
    this.interest,
    this.starSign,
    this.community,
    this.lifestyle,
    this.intentions,
    this.description,
    this.personality,
    required this.age,
    this.profileImage,
    required this.name,
    this.educationLevel,
    this.languages = const [],
    this.galleryImages = const [],
    this.subscriptionType = 'Free',
  });

  void upgradeSubscription(String newType) {
    subscriptionType = newType;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'profileImage': profileImage,
      'description': description,
      'bio': bio,
      'gender': gender,
      'birthday': birthday,
      'born': born,
      'educationLevel': educationLevel,
      'jobTitle': jobTitle,
      'height': height,
      'drink': drink,
      'religion': religion,
      'community': community,
      'interest': interest,
      'starSign': starSign,
      'workout': workout,
      'personality': personality,
      'intentions': intentions,
      'city': city,
      'languages': languages,
      'lifestyle': lifestyle,
      'subscriptionType': subscriptionType,
      'country': country,
    };
  }
}