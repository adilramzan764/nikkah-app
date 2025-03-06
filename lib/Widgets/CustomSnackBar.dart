import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Customsnackbar {
  static void showSnackbar({
    required String title,
    required String message,
    required BuildContext context,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      backgroundColor: Colors.black12,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.only(top: 8.0, left: 10, right: 10),
      icon: Icon(Icons.person, color: Colors.grey),
      shouldIconPulse: false,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.bounceInOut,
    );
  }
}

class Customsnackbar_SignUpScreens {
  static void showSnackbar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
        duration: Duration(milliseconds: 700 ), // Set the duration to 1 second
      ),
    );
  }
}