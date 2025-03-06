import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final Color backgroundColor;

  const CustomChip({
    super.key,
    this.textStyle,
    required this.label,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Chip(
        backgroundColor: backgroundColor,
        label: Text(
          label,
          style: textStyle ?? TextStyles.userProfileScreenAboutMeContent,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
          side: const BorderSide(color: Colors.black45, width: 1),
        ),
      ),
    );
  }
}