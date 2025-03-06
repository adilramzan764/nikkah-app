import 'package:flutter/material.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import 'package:nikkah_app/res/images/images_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(child: Image.asset(MyImageClass.logInC)),
    );
  }
}
