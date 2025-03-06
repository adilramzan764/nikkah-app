import 'package:get/get.dart';
import '../model/chat_model.dart';
import '../model/match_model.dart';
import '../services/chat_services.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;
  var messages = <ChatModel>[].obs;
  var matches = <MatchModel>[].obs;
  final ChatService _chatService = ChatService();

  @override
  void onInit() {
    super.onInit();
    loadChatsAndMatches();
  }

  void loadChatsAndMatches() {
    isLoading.value = true;
    messages.value = _chatService.fetchMessages();
    matches.value = _chatService.fetchMatches();
    isLoading.value = false;
  }
}