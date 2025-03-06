import 'package:flutter/material.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, -2),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildCustomNavItem(Icons.auto_awesome, "Explore", 0)),
          Expanded(child: _buildCustomNavItem(Icons.grid_view, "Grid", 1)),
          Expanded(child: _buildCustomNavItem(Icons.home, "Home", 2)),
          Expanded(child: _buildCustomNavItem(Icons.chat, "Chat", 3)),
          Expanded(child: _buildCustomNavItem(Icons.person, "Profile", 4)),
        ],
      ),
    );
  }

  Widget _buildCustomNavItem(IconData icon, String label, int index) {
    bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            width: 81,
            height: 38,
            decoration: BoxDecoration(
              gradient: isSelected
              ? const LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ) : null,
              borderRadius: BorderRadius.circular(30),
              color: isSelected ? null : Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
                if (isSelected) ...[
                  const SizedBox(width: 2),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}