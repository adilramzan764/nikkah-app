import 'package:flutter/material.dart';
import 'package:nikkah_app/res/styles/app_text_style.dart';

class RepeatedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const RepeatedText({
    super.key,
    this.style,
    this.textAlign,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyles.headingOne,
    );
  }
}