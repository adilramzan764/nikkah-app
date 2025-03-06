import '../HomeScreen/home_screen.dart';
import '../ExploreScreens/explore_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../view_model/home_controller.dart';
import 'package:nikkah_app/view/ChatScreens/chat_screen.dart';
import '../../res/components/custom_home_bottom_nav.dart';
import 'package:nikkah_app/view/UserProfileScreen/user_profile_screen.dart';
import 'package:nikkah_app/view/ExploreScreens/explore_category_screen.dart';

class MainHomeScreen extends StatelessWidget {
  final CompanionViewModel viewModel = Get.put(CompanionViewModel());

  MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: viewModel.pageController,
                onPageChanged: viewModel.changePage,
                children: [
                  ExploreScreen(),
                  CategoryExploreScreen(),
                  // UserListScreen(),
                  ProfileCardScreen(viewModel: viewModel),
                  ChatScreen(),
                  const UserProfileScreen(),
                ],
              ),
            ),
            const SizedBox(height: 2),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return CustomBottomNav(
          currentIndex: viewModel.currentIndex,
          onTap: (index) {
            // Change the PageView's page when a tab is tapped
            viewModel.changePage(index);
            viewModel.pageController.jumpToPage(index);
          },
        );
      }),
    );
  }
}