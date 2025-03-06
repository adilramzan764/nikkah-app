import '../colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchAvatar extends StatelessWidget {
  final int age;
  final String name;
  final String imagePath;
  final VoidCallback? onTap;

  const MatchAvatar({
    super.key,
    this.onTap,
    required this.age,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.5.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Flexible(
            child: Text(
              "$name, $age",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.chatScreenMatchesName,
            ),
          ),
        ],
      ),
    );
  }
}