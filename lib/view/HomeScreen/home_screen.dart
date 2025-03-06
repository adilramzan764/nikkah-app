import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../view_model/home_controller.dart';
import '../../res/components/custom_home_header.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import '../../res/components/custom_home_profile_card.dart';

class ProfileCardScreen extends StatelessWidget {
  final CompanionViewModel viewModel;

  const ProfileCardScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = viewModel.currentUser;

      if (user == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomHeader(),
            Expanded(
              child: ProfileCard(
                user: user,
                isLiked: viewModel.isLiked,
                onLike: viewModel.likeUser,
                isDisliked: viewModel.isDisliked,
                onDislike: viewModel.dislikeUser,
              ),
            ),
          ],
        ),
      );
    });
  }
}