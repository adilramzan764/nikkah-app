import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/chat_controller.dart';
import '../../res/components/custom_msg_tile.dart';
import '../../res/components/custom_match_avatar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: Text(
            "Chats",
            style: TextStyles.chatHeader,
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, size: 24.sp, color: AppColors.greyColor,),
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Matches",
                  style: TextStyles.chatHeaderTwo,
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 120.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.matches.length,
                    separatorBuilder: (context, index) => SizedBox(width: 8.w),
                    itemBuilder: (context, index) {
                      final match = controller.matches[index];
                      return MatchAvatar(
                        onTap: () {},
                        age: match.age,
                        name: match.name,
                        imagePath: match.avatarPath,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0.w, top: 5.0.h),
                  child: Text(
                    "Messages",
                    style: TextStyles.chatHeaderTwo,
                  ),
                ),
                SizedBox(height: 10.0.h),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      return MessageTile(
                        id: message.id,
                        name: message.name,
                        date: message.date,
                        message: message.message,
                        isOnline: message.isOnline,
                        avatarPath: message.avatarPath,
                        isYourTurn: message.isYourTurn,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}