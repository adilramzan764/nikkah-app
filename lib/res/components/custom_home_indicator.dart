import 'package:flutter/material.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';

class StepIndicator extends StatelessWidget {
  final bool isActive;

  const StepIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive ? AppColors.whiteColor : AppColors.stepperColor,
      ),
    );
  }
}