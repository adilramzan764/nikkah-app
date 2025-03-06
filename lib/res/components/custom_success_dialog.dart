import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';
import '../../view_model/dialog_controller.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWelcomeDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onClose;
  final WelcomeDialogViewModel viewModel;

  CustomWelcomeDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onClose,
  }) : viewModel = Get.put(WelcomeDialogViewModel(
    title: title,
    message: message,
  ));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 330.w,
              height: 330.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.r,
                    spreadRadius: 2.r,
                    color: Colors.black26,
                    offset: Offset(0, 5.h),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 163.w,
                      height: 163.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(Icons.beenhere, color: Colors.white, size: 60.sp,),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() => Text(
                      viewModel.title,
                      style: TextStyles.dialogHeading,
                    )),
                    SizedBox(height: 10.h),
                    Obx(() => Text(
                      viewModel.message,
                      textAlign: TextAlign.center,
                      style: TextStyles.dialogBody,
                    )),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15.h,
              right: 15.w,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Icon(Icons.close, size: 30.sp, color: Colors.black,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}