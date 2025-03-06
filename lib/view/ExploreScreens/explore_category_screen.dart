import 'package:get/get.dart';
import '../free_tonight_screen.dart';
import 'package:flutter/material.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import '../../res/components/explore_category_cards.dart';
import '../../res/components/custom_category_section.dart';
import 'package:nikkah_app/view_model/category_explore_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryExploreScreen extends StatelessWidget {
  final CategoryViewModels viewModel = Get.put(CategoryViewModels());

  CategoryExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Obx(() {
          if (viewModel.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: AppColors.whiteColor,
                floating: true,
                title: Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // My Vibes Section
              const SliverToBoxAdapter(
                child: SectionTitle(title: 'My Vibes...'),
              ),
              SliverToBoxAdapter(
                child: MasonryGridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemCount: viewModel.myVibes.length,
                  itemBuilder: (context, index) {
                    final category = viewModel.myVibes[index];
                    return AspectRatio(
                      aspectRatio: index % 2 == 0 ? 0.9 : 1.2,
                      child: CategoryCard(
                        title: category.title,
                        imageUrl: category.imageUrl,
                        onTap: () {
                          // Check if the category is "Free Tonight"
                          if (category.title == 'Free Tonight') {
                            Get.to(() => FreeTonightScreen());
                          } else {
                            // Keep the default navigation for other categories
                            Get.toNamed('/category/${category.title}');
                          }
                        },
                        titleAlignment: Alignment.topLeft,
                      ),
                    );
                  },
                ),
              ),
              // For You Section
              const SliverToBoxAdapter(
                child: SectionTitle(
                  title: 'For you',
                  subtitle: 'Recommendations',
                ),
              ),
              SliverToBoxAdapter(
                child: MasonryGridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemCount: viewModel.forYou.length,
                  itemBuilder: (context, index) {
                    final category = viewModel.forYou[index];
                    return AspectRatio(
                      aspectRatio: index % 3 == 0 ? 1.2 : 0.9,
                      child: CategoryCard(
                        title: category.title,
                        imageUrl: category.imageUrl,
                        titleAlignment: Alignment.center,
                        onTap: () => Get.toNamed('/category/${category.title}'),
                      ),
                    );
                  },
                ),
              ),
              // Bottom padding
              const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
            ],
          );
        }),
      ),
    );
  }
}