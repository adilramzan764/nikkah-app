import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text:  TextSpan(
              children: [
                TextSpan(
                  text: 'Find your ',
                  style: TextStyles.homeHeaderSmall,
                ),
                TextSpan(
                  text: 'Companion',
                  style: TextStyles.homeHeaderLarge,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune,),
          ),
        ],
      ),
    );
  }
}