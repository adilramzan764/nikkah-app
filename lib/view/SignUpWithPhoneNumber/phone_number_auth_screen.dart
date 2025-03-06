import 'package:get/get.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/components/custom_signup_button.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nikkah_app/res/styles/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/PhoneAuthContoller.dart';

class PhoneNumberAuthScreen extends StatelessWidget {
  PhoneNumberAuthScreen({super.key});

  final PhoneAuthController controller = Get.put(PhoneAuthController()); // Inject controller
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text("Your Number", style: TextStyles.appBarText),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 38.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Country", style: TextStyles.countryAndPhone),
                SizedBox(width: 120.w),
                Text("Phone Number", style: TextStyles.countryAndPhone),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IntlPhoneField(
                      controller: phoneController,
                      initialCountryCode: 'PK',
                      disableLengthCheck: true,
                      onChanged: (phone) {
                        phoneController.text = phone.completeNumber; // Ensure full number is used
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "",
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Flexible(
                  flex: 3,
                  child: Container(
                    height: 60.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0312-0040044",
                          hintStyle: TextStyles.textButton.copyWith(
                              color: AppColors.greyColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Obx(() => CustomSignUpButton(
              text: controller.isLoading.value ? "Sending..." : "Send",
              onPressed: () => controller.sendOTP('+923156590340'),
            )),
          ],
        ),
      ),
    );
  }
}
