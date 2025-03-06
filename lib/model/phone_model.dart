class PhoneNumberModel {
  final String countryCode;
  final String phoneNumber;

  PhoneNumberModel({
    required this.countryCode,
    required this.phoneNumber,
  });

  @override
  String toString() {
    return '$countryCode $phoneNumber';
  }
}