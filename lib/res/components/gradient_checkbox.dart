import 'package:flutter/material.dart';
import 'package:nikkah_app/res/colors/colors.dart';

class GradientCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const GradientCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          gradient: value ? const LinearGradient(
            colors: [
              Color(0xFF43CBFF),
              Color(0xFF9708CC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ) : null,
          color: value ? null : AppColorsTwo.whiteColor,
          border: Border.all(color: Colors.grey.shade600),
          borderRadius: BorderRadius.circular(4),
        ),
        child: value ? const Icon(Icons.check, color: Colors.white, size: 20,) : null,
      ),
    );
  }
}