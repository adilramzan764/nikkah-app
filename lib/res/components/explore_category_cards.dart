import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final Alignment titleAlignment;

  const CategoryCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.imageUrl,
    this.titleAlignment = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.transparent,
              ],
            ),
          ),
          child: Align(
            alignment: titleAlignment,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                title,
                style: TextStyles.exploreCategoryScreen,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }
}