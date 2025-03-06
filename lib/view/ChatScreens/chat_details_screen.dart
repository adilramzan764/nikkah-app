import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../view_model/message_controller.dart';
import '../../res/components/custom_message_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/components/custom_safety_toolkit_bottomsheet.dart';

class ChatDetailScreen extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());

  ChatDetailScreen({super.key});

  void _showSafetyToolkit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return const SafetyToolkitSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(controller.userAvatar),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.userName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (controller.isOnline) Text(
                    'Active Now',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.grey),
            ),
            IconButton(
              onPressed: () => _showSafetyToolkit(context),
              icon: const Icon(Icons.gpp_bad, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return MessageBubble(
                    time: message.time,
                    message: message.message,
                    isSentByMe: message.isSentByMe,
                    emojiReaction: message.emojiReaction,
                    onReactionSelected: (emoji) {
                      controller.addReaction(index, emoji);
                    },
                  );
                },
              );
            }),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.r),
                        borderSide: const BorderSide(
                          width: 1.5,
                          color: AppColors.greyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.r),
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: AppColors.greyColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.r),
                        borderSide:  const BorderSide(
                          width: 0.5,
                          color: AppColors.greyColor,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 20.w,
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 28.sp,
                          color: AppColors.greyColor,
                        ),
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          builder: (_) => _buildBottomSheet(context),
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: TextButton(
                          onPressed: () => controller.sendMessage(
                            controller.messageController.text,
                          ),
                          child: Obx(() {
                            return Text(
                              'Send',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: controller.isSendButtonBlue.value
                                ? AppColors.blueColor
                                : AppColors.greyColor,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomSheetIcon(
            context,
            icon: Icons.gif,
            onTap: () => Get.back(),
          ),
          SizedBox(height: 16.h),
          _buildBottomSheetIcon(
            context,
            onTap: () =>Get.back(),
            icon: Icons.keyboard_voice,
          ),
          SizedBox(height: 16.h),
          _buildBottomSheetIcon(
            context,
            icon: Icons.image,
            onTap: () => Get.back(),
          ),
          SizedBox(height: 16.h),
          _buildBottomSheetIcon(
            context,
            icon: Icons.videocam,
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetIcon(BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.primaryColor.withOpacity(0.2),
            child: Icon(icon, color: AppColors.primaryColor, size: 24.sp),
          ),
        ],
      ),
    );
  }
}