import 'package:get/get.dart';
import '../list/emoji_list.dart';
import '../colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatelessWidget {
  final String time;
  final String message;
  final bool isSentByMe;
  final String? emojiReaction;
  final Function(String) onReactionSelected;

  const MessageBubble({
    super.key,
    required this.time,
    this.emojiReaction,
    required this.message,
    required this.isSentByMe,
    required this.onReactionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showEmojiReactions(context);
      },
      child: Align(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
          isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: isSentByMe ? AppColors.primaryColor : Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isSentByMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Emoji Reaction Container
                if (emojiReaction != null) Positioned(
                  bottom: -10,
                  left: isSentByMe ? null : 10,
                  right: isSentByMe ? 10 : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Text(
                      emojiReaction!,
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: isSentByMe ? 0 : 4.w,
                right: isSentByMe ? 4.w : 0,
                top: emojiReaction != null ? 12.h : 4.h,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSentByMe) ...[
                    Icon(
                      size: 14.sp,
                      Icons.done_all,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(width: 4.w),
                  ],
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmojiReactions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(bottom: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...['👍', '❤️', '😂', '😮', '😢', '👎'].map(
                (emoji) => GestureDetector(
                  onTap: () {
                    onReactionSelected(emoji);
                    Get.back;
                  },
                  child: Text(
                    emoji,
                    style: TextStyle(
                      fontSize: 32.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  _showMoreEmojis(context);
                },
                child: Icon(Icons.add_circle_outline, size: 32.sp, color: Colors.grey,),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMoreEmojis(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
            ),
            itemCount: moreEmojis.length,
            itemBuilder: (context, index) {
              final emoji = moreEmojis[index];
              return GestureDetector(
                onTap: () {
                  onReactionSelected(emoji);
                  Get.back();
                },
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 32.sp,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}