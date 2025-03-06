class MessageModel {
  final String time;
  final String message;
  final bool isSentByMe;
  final String? emojiReaction;

  MessageModel({
    required this.time,
    this.emojiReaction,
    required this.message,
    required this.isSentByMe,
  });
}