import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';

class SkipButton extends StatelessWidget {
  final String label;
  final String routeName;
  final EdgeInsetsGeometry padding;

  const SkipButton({
    super.key,
    this.label = 'Skip',
    required this.routeName,
    this.padding = const EdgeInsets.only(bottom: 8.0, left: 180.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextButton(
        onPressed: () {
          Get.toNamed(routeName,arguments: {'isSignUp': true});
        },
        child: Text(
          label,
          style: TextStyles.skipButton,
        ),
      ),
    );
  }
}