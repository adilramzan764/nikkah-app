import '../colors/app_colors.dart';
import '../styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileButtons extends StatelessWidget {
  final bool isPreviewActive;
  final VoidCallback onEditPressed;
  final VoidCallback onPreviewPressed;

  const ProfileButtons({
    super.key,
    required this.onEditPressed,
    required this.isPreviewActive,
    required this.onPreviewPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onEditPressed,
            child: Container(
              width: 90.w,
              height: 35.h,
              decoration: BoxDecoration(
                gradient: isPreviewActive ? null : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                ),
                borderRadius: BorderRadius.circular(18.sp),
              ),
              child: Center(
                child: Text(
                  'Edit',
                  style: isPreviewActive
                  ? TextStyles.editProfileScreenPreviewButton
                  : TextStyles.editProfileScreenEditButton,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: onPreviewPressed,
            child: Container(
              width: 106.w,
              height: 35.h,
              decoration: BoxDecoration(
                gradient: isPreviewActive
                ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                )
                : null,
                borderRadius: BorderRadius.circular(18.sp),
              ),
              child: Center(
                child: Text(
                  'Preview',
                  style: isPreviewActive
                  ? TextStyles.editProfileScreenEditButton
                  : TextStyles.editProfileScreenPreviewButton,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}