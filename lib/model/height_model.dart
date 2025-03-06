class HeightModel {
  final String feet;
  final String inches;
  final String measurement;

  HeightModel({
    required this.feet,
    required this.inches,
    required this.measurement,
  });

  String get display => "$feet'$inches\" ($measurement)";
}