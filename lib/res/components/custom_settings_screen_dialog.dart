import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import 'package:nikkah_app/res/styles/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String cancelButtonText;
  final String confirmButtonText;
  final List<Color> confirmButtonGradientColors;

  const CustomDialog({
    super.key,
    this.onCancel,
    required this.icon,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.cancelButtonText,
    required this.confirmButtonText,
    this.confirmButtonGradientColors = const [
      AppColors.primaryColor,
      AppColors.secondaryColor,
    ],
  });

  static void show({
    required String title,
    required IconData icon,
    VoidCallback? onCancel,
    required String message,
    required VoidCallback onConfirm,
    required String cancelButtonText,
    required String confirmButtonText,
    List<Color> confirmButtonGradientColors = const [
      AppColors.primaryColor,
      AppColors.secondaryColor,
    ],
  }) {
    Get.defaultDialog(
      backgroundColor: AppColors.whiteColor,
      titlePadding: EdgeInsets.zero,
      title: "",
      contentPadding: const EdgeInsets.only(left: 10, right: 10),
      content: CustomDialog(
        icon: icon,
        title: title,
        message: message,
        onCancel: onCancel,
        onConfirm: onConfirm,
        cancelButtonText: cancelButtonText,
        confirmButtonText: confirmButtonText,
        confirmButtonGradientColors: confirmButtonGradientColors,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon with Gradient Background
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor.withOpacity(0.4),
                AppColors.secondaryColor.withOpacity(0.6),
              ],
            ),
          ),
          child: Icon(
            icon,
            size: IconSize.deleteIcon.size,
            color: IconSize.deleteIcon.color,
          ),
        ),
        const SizedBox(height: 16),
        // Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        // Message
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 20.h),
        // Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onConfirm,
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: confirmButtonGradientColors,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextButton(
                      onPressed: null,
                      child: Text(
                        confirmButtonText,
                        style: TextStyles.confirm,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Cancel Button
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: TextButton(
                    onPressed: onCancel ?? () => Get.back(),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(color: AppColors.greyColor),
                      ),
                    ),
                    child: Text(
                      cancelButtonText,
                      style: TextStyles.cancelText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}