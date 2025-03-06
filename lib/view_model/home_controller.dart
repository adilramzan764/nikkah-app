import 'package:get/get.dart';
import '../model/main_user_model.dart';
import 'package:flutter/material.dart';

class CompanionViewModel extends GetxController {
  final _isLiked = false.obs;
  final _isActive = true.obs;
  final _currentIndex = 2.obs;
  final _isDisliked = false.obs;
  final _currentImageIndex = 0.obs;
  final List<int> pageHistory = [2];
  final _currentUser = Rx<MainUserModel?>(null);
  final PageController pageController = PageController(initialPage: 2);

  bool get isLiked => _isLiked.value;
  bool get isActive => _isActive.value;
  bool get isDisliked => _isDisliked.value;
  int get currentIndex => _currentIndex.value;
  MainUserModel? get currentUser => _currentUser.value;
  int get currentImageIndex => _currentImageIndex.value;

  final List<MainUserModel> _originalUsers = [
    MainUserModel(
      id: '1',
      age: 23,
      distanceKm: 2.5,
      location: 'New York',
      name: 'Galina Fisher',
      imageUrls: [
        'assets/home-image.png',
        'assets/home-image.png',
        'assets/home-image.png',
        'assets/onboarding-image.png',
      ],
      profession: 'Software Engineer',
    ),
  ];

  final List<MainUserModel> _users = [];

  @override
  void onInit() {
    super.onInit();
    _users.addAll(_originalUsers);
    loadNextUser();
  }

  void setImageIndex(int index) {
    _currentImageIndex.value = index;
  }

  void nextImage() {
    if (_currentUser.value != null &&
        _currentImageIndex.value < _currentUser.value!.imageUrls.length - 1) {
      _currentImageIndex.value++;
    }
  }

  void previousImage() {
    if (_currentImageIndex.value > 0) {
      _currentImageIndex.value--;
    }
  }

  void refreshCurrentUser() {
    if (_currentUser.value != null) {
      _currentImageIndex.value = 0;
      _isLiked.value = false;
      _isDisliked.value = false;
      _isActive.value = true;

      if (_users.isEmpty) {
        _users.addAll(_originalUsers);
      }
    }
  }

  void loadNextUser() {
    if (_users.isNotEmpty) {
      _currentUser.value = _users.removeAt(0);
      _currentImageIndex.value = 0;
      _isLiked.value = false;
      _isDisliked.value = false;
      _isActive.value = true;
    }
  }

  void likeUser() {
    if (_isLiked.value) {
      _isLiked.value = false;
    } else {
      _isLiked.value = true;
      _isDisliked.value = false;
      Future.delayed(const Duration(milliseconds: 500), loadNextUser);
    }
  }

  void dislikeUser() {
    if (_isDisliked.value) {
      _isDisliked.value = false;
    } else {
      _isDisliked.value = true;
      _isLiked.value = false;
      Future.delayed(const Duration(milliseconds: 500), loadNextUser);
    }
  }

  // void changePage(int index) {
  //   _currentIndex.value = index;
  // }

  void changePage(int index) {
    if (_currentIndex.value != index) {
      pageHistory.add(_currentIndex.value); // Previous index store karna
      _currentIndex.value = index;
    }
  }

  void goBack() {
    if (pageHistory.isNotEmpty) {
      int lastIndex = pageHistory.removeLast(); // Last visited index nikalna
      _currentIndex.value = lastIndex;
      pageController.jumpToPage(lastIndex);
    }
  }

  void toggleActiveStatus() {
    _isActive.toggle();
  }
}