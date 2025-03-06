class ChatModel {
  final String id;
  final String name;
  final String date;
  final bool isOnline;
  final String message;
  final bool isYourTurn;
  final String avatarPath;

  ChatModel({
    required this.id,
    required this.name,
    required this.date,
    required this.message,
    required this.isOnline,
    required this.isYourTurn,
    required this.avatarPath,
  });
}