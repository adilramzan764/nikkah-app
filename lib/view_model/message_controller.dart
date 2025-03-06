import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/message_model.dart';
import 'package:flutter/cupertino.dart';
import '../services/message_services.dart';

class MessageController extends GetxController {
  final MessageService _messageService = MessageService();
  final messageController = TextEditingController();

  var isLoading = false.obs;
  var isSendButtonBlue = false.obs;
  var messages = <MessageModel>[].obs;

  late final String chatId;
  late final bool isOnline;
  late final String userName;
  late final String userAvatar;

  @override
  void onInit() {
    super.onInit();
    chatId = Get.arguments['chatId'];
    userName = Get.arguments['name'];
    userAvatar = Get.arguments['avatar'];
    isOnline = Get.arguments['isOnline'];
    loadMessages();

    messageController.addListener(() {
      if (messageController.text.trim().isEmpty) {
        isSendButtonBlue.value = false;
      } else {
        isSendButtonBlue.value = true;
      }
    });
  }

  void loadMessages() {
    isLoading.value = true;
    messages.value = _messageService.fetchMessages(chatId);
    isLoading.value = false;
  }

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;

    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    messages.add(MessageModel(
      message: message,
      time: formattedTime,
      isSentByMe: true,
    ));

    messageController.clear();
  }

  void addReaction(int index, String emoji) {
    messages[index] = MessageModel(
      message: messages[index].message,
      time: messages[index].time,
      isSentByMe: messages[index].isSentByMe,
      emojiReaction: emoji,
    );
  }
}