import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../../view_model/image_controller.dart';

class ImageGridItem extends StatelessWidget {
  final int index;
  final String? imageUrl;

  const ImageGridItem({super.key, required this.index, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ImageController>(); // Use Get.find()

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
                errorWidget: (context, url, error) => const Icon(Icons.error),
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















