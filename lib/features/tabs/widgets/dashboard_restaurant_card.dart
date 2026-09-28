import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomImage.dart';

import '../../../core/utils/Colors.dart';
import '../../../core/widgets/CustomText.dart';

class DashboardRestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String restaurantName;
  final String location;
  final String rating;
  final String deliveryTime;
  final String? badgeText;
  final String? startingPrice;
  final String? categories;

  const DashboardRestaurantCard({
    super.key,
    required this.imageUrl,
    required this.restaurantName,
    required this.location,
    required this.rating,
    required this.deliveryTime,
    this.badgeText,
    this.startingPrice,
    this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: CustomImage(
                  isNetwork: true,
                  source: imageUrl,
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   child: CustomImage(
              //     source: Images.gradient,
              //     borderRadius: BorderRadius.circular(12),
              //     height: 100,
              //     width: 120,
              //   ),
              // ),
              // Positioned(
              //   right: 0,
              //   top: 0,
              //   child: CustomImage(
              //     source: Images.topRightShadow,
              //     borderRadius: BorderRadius.circular(10),
              //     height: 50,
              //     width: 50,
              //     isSvg: true,
              //     // borderRadius: BorderRadius.circular(10),
              //   ),
              // ),
              // Positioned(
              //   right: 6,
              //   top: 6,
              //   child: CustomImage(
              //     source: Images.heart,
              //     isSvg: true,
              //     height: 24,
              //     width: 24,
              //     color: AppColors.white,
              //     // borderRadius: BorderRadius.circular(10),
              //   ),
              // ),
              Positioned(
                top: 10,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      color: Color(0xFF0F172A),
                      borderRadius: BorderRadius.all(Radius.circular(6.r))
                  ),
                  child:
                    CustomText(
                      "ITEMS AT ₹$startingPrice",
                      color: AppColors.white,
                      fontSize: 10.sp,
                      fontWeight: Fonts.bold,
                    ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    restaurantName,
                    maxLines: 2,
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                    fontWeight: Fonts.bold,
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    children: [
                      // Green star container
                      Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                            Icons.star, size: 12, color: AppColors.white),
                      ),
                      SizedBox(width: 2.w),

                      // Rating & reviews
                      CustomText(
                          rating, fontSize: 11.sp, fontWeight: Fonts.semiBold),
                      SizedBox(width: 2),

                      // Dot separator
                      CustomText(
                          "•", fontSize: 11.sp, fontWeight: Fonts.semiBold),
                      SizedBox(width: 2),
                      // Delivery time
                      CustomText(
                        deliveryTime,
                        fontSize: 11.sp,
                        fontWeight: Fonts.semiBold,
                      ),
                    ],
            ),
                  SizedBox(height: 2.h,),
                  CustomText(categories!, color: AppColors.textSecondary,
                    fontSize: 11.sp,),
                ]
            ),
          ),
        ],
      ),
    );
  }
}
