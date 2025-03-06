import 'package:get/get.dart';
import '../model/onboarding_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:nikkah_app/routes/routes_name.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  var pageController = PageController();

  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'Welcome to Nikkah App',
      imageUrl: 'assets/onboarding-image.png',
      description: 'Your trusted companion for planning and managing your Nikkah journey.',
    ),
    OnboardingModel(
      title: 'Simplify Your Planning',
      imageUrl: 'assets/onboarding-image.png',
      description: 'Easily organize your Nikkah details, invitations, and more.',
    ),
    OnboardingModel(
      title: 'Join Our Community',
      imageUrl: 'assets/onboarding-image.png',
      description: 'Connect with others and make your Nikkah event unforgettable.',
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(RoutesName.loginAScreen);
    }
  }

  void skipToLastPage() {
    pageController.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 30),
      curve: Curves.easeIn,
    );
  }
}