import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/otp_controller.dart';
import '../../res/components/custom_signup_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class PhoneOtpScreen extends StatelessWidget {
  final OtpViewModel controller = Get.put(OtpViewModel());

  PhoneOtpScreen({super.key}) {
    controller.startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          "Enter OTP",
          style: TextStyles.appBarText.copyWith(
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.sp),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 38.w,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Verify OTP Code", style: TextStyles.verifyOtp,),
            SizedBox(height: 8.h),
            Text(
              "A code was sent to ${controller.otpModel.phoneNumber}",
              style: TextStyles.verifyOtp.copyWith(
                color: AppColors.greyColor,
              ),
            ),
            SizedBox(height: 32.h),
            OtpTextField(
              numberOfFields: 6,
              borderColor: AppColors.greyColor,
              textStyle: TextStyle(fontSize: 18.sp),
              borderRadius: BorderRadius.circular(5.r),
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                // Handle when the user modifies the OTP fields
              },
              onSubmit: (String otpCode) {
                // Store the OTP code in the controller
                controller.otpInput.value = otpCode;
              },
            ),
            SizedBox(height: 32.h),

            Obx(
              () => Center(
                child: Text(
                  "Resend code in: 00:${controller.resendTimer.value.toString().padLeft(2, '0')}",
                  style: TextStyles.verifyOtp,
                ),
              ),
            ),
            SizedBox(height: 32.h),

            Obx(
              () => Center(
                child: controller.resendTimer.value > 0 ? CustomSignUpButton(
                  text: 'Verify',
                  onPressed: () => controller.verifyOtp(),
                ) : CustomSignUpButton(
                  text: 'Resend',
                  onPressed: () {
                    controller.clearOtp();
                    controller.startResendTimer();
                    // Add OTP resend logic here
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}