import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabButton({super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h,),
        decoration: BoxDecoration(
          gradient: isSelected
          ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
          )
          : null,
          border: Border.all(
            width: 1.w,
            color: isSelected ? Colors.transparent : AppColors.greyColor,
          ),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Text(
          text,
          style: isSelected
          ? TextStyles.exploreScreenSelectTabButton
          : TextStyles.exploreScreenUnSelectTabButton,
        ),
      ),
    );
  }
}