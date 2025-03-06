import 'package:flutter/material.dart';
import '../../model/interest_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:nikkah_app/res/colors/colors.dart';

class InterestChip extends StatelessWidget {
  final Interest interest;
  final VoidCallback onTap;

  const InterestChip({
    super.key,
    required this.onTap,
    required this.interest,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 3, bottom: 8),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          padding: EdgeInsets.zero,
          dashPattern: const [6, 3],
          color: interest.isSelected ? Colors.transparent : Colors.grey.shade300,
          strokeWidth: 3,
          child: Container(
            decoration: BoxDecoration(
              gradient: interest.isSelected ? const LinearGradient(
                colors: [
                  AppColorsTwo.primaryColor,
                  AppColorsTwo.secondaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ) : null,
              borderRadius: BorderRadius.circular(20),
              color: interest.isSelected ? null : Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  interest.icon,
                  style: TextStyle(
                    fontSize: 12,
                    color: interest.isSelected ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  interest.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: interest.isSelected ? Colors.white : Colors.black87,
                    fontWeight: interest.isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}