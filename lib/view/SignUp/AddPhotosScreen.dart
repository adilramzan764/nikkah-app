import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/custom_image_grid.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/components/custom_stepper.dart';
import '../../res/components/custom_success_dialog.dart';
import '../../res/styles/app_text_style.dart';
import '../../routes/routes_name.dart';
import '../../view_model/AddPhotos_Conrtoller.dart';
import 'dart:io'; // Import to handle local files

class AddPhotos_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addPhotosController = Get.put(AddPhotos_Controller());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomStepper(currentStep: 17, totalSteps: 17),
            SizedBox(height: 20.h),
            Text('Add your Photos', style: TextStyles.appBarText),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 160.h,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => Obx(() {
                  final imageUrl = index < addPhotosController.imageList.length
                      ? addPhotosController.imageList[index]
                      : null;
                  print('Image URL at index $index: $imageUrl'); // Debug print
                  return ImageGridItem_AddPhtosScreen(
                    index: index,
                    imageUrl: imageUrl,
                  );
                }),
              ),
            ),
            Center(
              child: CustomSignUpButton(
                text: 'Done',
                onPressed: () async {
                  if (addPhotosController.hasImages) {
                    // Images are already being saved to Firebase when picked,
                    // so we don't need to call saveImageUrlToDatabase again
                    Get.dialog(
                      CustomWelcomeDialog(
                        title: "Great!",
                        message: "Your photos have been uploaded successfully!",
                        onClose: () {
                          Get.back();
                          Get.offAllNamed(RoutesName.loginCScreen);
                        },
                      ),
                      barrierDismissible: false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please select at least one image.',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        duration: Duration(seconds: 1), // Show snackbar for 1 second
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class ImageGridItem_AddPhtosScreen extends StatelessWidget {
  final int index;
  final String? imageUrl;

  const ImageGridItem_AddPhtosScreen({super.key, required this.index, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPhotos_Controller>();

    return GestureDetector(
      onTap: () => controller.pickImage(index),
      child: Stack(
        children: [
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  print('Error loading image: $error'); // Debug print
                  return const Icon(Icons.error);
                },
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                color: AppColors.photoAddIconColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.add_photo_alternate, color: AppColors.whiteColor, size: 32),
              ),
            ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                ),
              ),
              child: Icon(imageUrl != null ? Icons.edit : Icons.add, color: AppColors.whiteColor, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}