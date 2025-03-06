import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';
import 'package:nikkah_app/model/explore_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreProfileCard extends StatelessWidget {
  final double height;
  final ExploreUserModel user;

  const ExploreProfileCard({
    super.key,
    required this.user,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(user.imageUrl, fit: BoxFit.cover,),
            Positioned(
              left: 8.w,
              bottom: 20.h,
              child: IntrinsicWidth(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${user.name}, ${user.age}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.exploreScreenImage,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            size: 12,
                            color: Colors.white,
                            Icons.location_on_outlined,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${user.location}, ${user.matchStatus}',
                            style: TextStyles.exploreScreenImageLocationAndMatch,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}