class Intention {
  final String id;
  bool isSelected;
  final String title;

  Intention({
    required this.id,
    required this.title,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isSelected': isSelected,
  };

  factory Intention.fromJson(Map<String, dynamic> json) {
    return Intention(
      id: json['id'],
      title: json['title'],
      isSelected: json['isSelected'] ?? false,
    );
  }
}