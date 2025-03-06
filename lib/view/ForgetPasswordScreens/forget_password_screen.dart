import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../res/colors/app_colors.dart';
import '../../res/components/custom_repeated_text.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/components/custom_text_field.dart';
import '../../res/images/images_assets.dart';
import '../../res/styles/app_text_style.dart';
import '../../routes/routes_name.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendVerificationEmail(String email) async {
    try {
      // Check if the email is associated with an existing account
      var methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        // Send email verification link
        await _auth.sendPasswordResetEmail(email: email);
        Get.snackbar(
          'Success',
          'Password reset email sent to $email. Please check your inbox.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'No account found with this email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send password reset email: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.w),
            child: Column(
              children: [
                SizedBox(height: 35.h),
                Center(
                  child: Image.asset(
                    width: 228.w,
                    height: 252.h,
                    MyImageClass.logInC,
                  ),
                ),
                SizedBox(height: 24.h),
                const RepeatedText(text: 'Find Your Perfect \nCompanion'),
                SizedBox(height: 24.h),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot Password',
                        style: TextStyles.forget,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Email Address',
                        style: TextStyles.textField,
                      ),
                      CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
                      ),
                      SizedBox(height: 32.h),
                      CustomSignUpButton(
                        text: 'Next',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            sendVerificationEmail(emailController.text.trim());
                          }
                        },
                      ),
                    ],
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