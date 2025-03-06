import '../model/message_model.dart';

class MessageService {
  List<MessageModel> fetchMessages(String chatId) {
    return [
      MessageModel(
        time: "10:30 AM",
        isSentByMe: false,
        message: "Hey, how are you?",
      ),
      MessageModel(
        time: "10:31 AM",
        isSentByMe: true,
        message: "I'm good, thanks! How about you?",
      ),
    ];
  }
}