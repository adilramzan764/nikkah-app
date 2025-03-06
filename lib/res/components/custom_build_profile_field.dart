import '../colors/app_colors.dart';
import '../styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBuildProfileField extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;
  final bool showDivider;
  final VoidCallback? onTap;
  const CustomBuildProfileField({
    super.key,
    this.icon,
    this.onTap,
    this.value,
    required this.title,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          ListTile(
            tileColor: AppColors.greyColor.withOpacity(0.1),
            title: Text(
              title,
              style: TextStyles.editProfileScreenListTitle,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (value != null)
                  SizedBox(
                    width: 200.w,
                    child: SingleChildScrollView(
                      child: Text(
                        value!,
                        textAlign: TextAlign.end,
                        style: TextStyles.editProfileScreenListTrailing,
                      ),
                    ),
                  ),
                SizedBox(width: 5.w,),
                if (icon != null)
                Icon(
                  icon,
                  size: 18,
                  color: AppColors.greyColor.withOpacity(0.5),
                ),
              ],
            ),
            onTap: onTap,
          ),
          if (showDivider) const Divider(height: 0.5),
        ],
      ),
    );
  }
}