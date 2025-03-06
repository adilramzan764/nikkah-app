import 'package:get/get.dart';
import '../styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SafetyToolkitSheet extends StatelessWidget {
  const SafetyToolkitSheet({super.key});

  Widget _buildSafetyOption({
    required String title,
    required IconData icon,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withOpacity(0.1),
              ),
              child: Icon(icon, color: iconColor, size: 30.sp,),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.safetyToolkitTitle,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyles.safetyToolkitSubTitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Safety Toolkit',
              style: TextStyles.safetyToolkitHeader,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSafetyOption(
            icon: Icons.cancel,
            onTap: () => Get.back(),
            iconColor: Colors.orange,
            title: 'UNMATCHED FROM KATHEREN',
            subtitle: 'No longer interested? Remove them from your matches.',
          ),
          _buildSafetyOption(
            title: 'BLOCK KATHEREN',
            onTap: () => Get.back(),
            iconColor: Colors.green,
            icon: Icons.block_flipped,
            subtitle: 'You won\'t see them and they won\'t see you.',
          ),
          _buildSafetyOption(
            iconColor: Colors.red,
            onTap: () => Get.back(),
            title: 'REPORT KATHEREN',
            icon: Icons.report_gmailerrorred_outlined,
            subtitle: 'Don\'t worry - we won\'t tell them',
          ),
          _buildSafetyOption(
            iconColor: Colors.blue,
            onTap: () => Get.back(),
            title: 'ACCESS SAFETY CENTER',
            icon: Icons.security_outlined,
            subtitle: 'Your well-being matters. Find safety resources and tools here.',
          ),
        ],
      ),
    );
  }
}