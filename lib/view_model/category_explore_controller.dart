import 'package:get/get.dart';
import '../model/category_explore_model.dart';

class CategoryViewModels extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<CategoryModel> forYou = <CategoryModel>[].obs;
  final RxList<CategoryModel> myVibes = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      myVibes.value = [
        CategoryModel(
          section: 'my_vibes',
          title: 'Looking for Love',
          imageUrl: 'assets/my-vibes-imgOne.png',
        ),
        CategoryModel(
          section: 'my_vibes',
          title: 'Free Tonight',
          imageUrl: 'assets/my-vibes_imgTwo.png',
        ),
        CategoryModel(
          section: 'my_vibes',
          title: "Let's be Friends",
          imageUrl: 'assets/my-vibes-imgThree.png',
        ),
        CategoryModel(
          section: 'my_vibes',
          title: 'Coffee Date',
          imageUrl: 'assets/my-vibes-imgFour.png',
        ),
      ];

      forYou.value = [
        CategoryModel(
          section: 'for_you',
          title: 'Date Night',
          imageUrl: 'assets/for-you-imgOne.png',
        ),
        CategoryModel(
          section: 'for_you',
          title: 'Binge Watchers',
          imageUrl: 'assets/for-you-imgTwo.png',
        ),
        CategoryModel(
          title: 'Creatives',
          section: 'for_you',
          imageUrl: 'assets/for-you-imgThree.png',
        ),
        CategoryModel(
          title: 'Sporty',
          section: 'for_you',
          imageUrl: 'assets/for-you-imgFour.png',
        ),
      ];

      isLoading.value = false;
    });
  }
}
