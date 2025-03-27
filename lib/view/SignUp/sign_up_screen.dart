import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/images/images_assets.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_text_field.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/components/custom_repeated_text.dart';
import '../../routes/routes_name.dart';
import '../../view_model/SignUp_Controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/Signup_Contoller.dart';
import 'location_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 38.w,),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    width: 252.w,
                    height: 228.h,
                    MyImageClass.logInC,
                  ),
                ),
                SizedBox(height: 24.h),
                const Center(child: RepeatedText(text: 'Create Your \nNew Account',),),
                SizedBox(height: 24.h),
                Text(' Sign Up', style: TextStyles.forget,),
                SizedBox(height: 16.h),
                Text(' Full Name', style: TextStyles.textField,),
                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: controller.fullName,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your full name' : null,
                ),
                SizedBox(height: 16.h),
                Text(' Email Address', style: TextStyles.textField,),
                CustomTextField(
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                Text(' Password', style: TextStyles.textField,),
                CustomTextField(
                  obscureText: true,
                  controller: controller.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]').hasMatch(value)) {
                      return 'Password must contain letters, numbers, and special characters';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),
                CustomSignUpButton(
                  text: 'Sign Up',
                  onPressed: () {

                    if (formKey.currentState!.validate()){
                      SignUpController.instance.registerUser(
                      );
                    }
                  },
                ),
                SizedBox(height: 16.h,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 10.w,
                        thickness: 0.5.h,
                        color: Colors.black,
                      ),
                    ),
                    Text("Or Sign Up with", style: TextStyles.textButton,),
                    Expanded(
                      child: Divider(
                        indent: 10.w,
                        thickness: 0.5.h,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          // controller.signInWithGoogle();
                          // Get.snackbar('Success', 'Signed in with Google successfully');
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                      child: SvgPicture.asset(
                        width: 40.w,
                        height: 40.h,
                        MyImageClass.facebookImage,
                      ),
                    ),
                    SizedBox(width: 35.w),
                    GestureDetector(
                      onTap: () => controller.signupWithGoogle(),
                      child: SvgPicture.asset(
                        width: 40.w,
                        height: 40.h,
                        MyImageClass.googleImage,
                        // Optional: Apply a color filter if needed
                      ),
                    ),
                    SizedBox(width: 35.w),

                    GestureDetector(
                      onTap: () => Get.toNamed(RoutesName.phoneNumberAuthScreen),
                      child: SvgPicture.asset(
                        width: 40.w,
                        height: 40.h,
                        MyImageClass.whatsappImage,
                        // Optional: Apply a color filter if needed
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}