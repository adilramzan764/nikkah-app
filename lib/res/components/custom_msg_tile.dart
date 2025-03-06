import 'package:get/get.dart';
import '../colors/app_colors.dart';
import '../styles/app_text_style.dart';
import 'package:flutter/material.dart';
import '../../view/ChatScreens/chat_details_screen.dart';

class MessageTile extends StatelessWidget {
  final String id;
  final String name;
  final String date;
  final bool isOnline;
  final String message;
  final bool isYourTurn;
  final String avatarPath;

  const MessageTile({
    super.key,
    required this.id,
    required this.date,
    required this.name,
    required this.message,
    required this.isOnline,
    required this.isYourTurn,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ChatDetailScreen(),
        arguments: {
          'chatId': id,
          'name': name,
          'avatar': avatarPath,
          'isOnline': isOnline,
        },
      ),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(avatarPath),
            ),
            if (isOnline) Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.activeColor,
                  border: Border.all(color: AppColors.whiteColor, width: 2),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          name,
          style: TextStyles.chatScreenUserTitle,
        ),
        subtitle: Text(
          message,
          style: TextStyles.chatScreenUserSubTitle,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isYourTurn)Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.yourTurnColorOne,
                    AppColors.yourTurnColorTwo,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(1),
                  bottomLeft: Radius.circular(1),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Text(
                "Your turn",
                style: TextStyles.chatScreenYourTurn,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}