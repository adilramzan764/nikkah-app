import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGradientSwitch extends StatelessWidget {
  final bool value;
  final Function() onChanged;

  const CustomGradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 50.w,
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: value ? const LinearGradient(
            end: Alignment.centerRight,
            begin: Alignment.centerLeft,
            colors: [Colors.blue, Colors.purple],
          ) : LinearGradient(
            end: Alignment.centerRight,
            begin: Alignment.centerLeft,
            colors: [Colors.grey.shade400, Colors.grey.shade600],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Align(
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 18.w,
              height: 18.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}