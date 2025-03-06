class InterestCategory {
  final String name;
  final List<Interest> interests;

  InterestCategory({
    required this.name,
    required this.interests,
  });
}

class Interest {
  final String id;
  bool isSelected;
  final String name;
  final String icon;

  Interest({
    required this.id,
    required this.name,
    required this.icon,
    this.isSelected = false,
  });
}