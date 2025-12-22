import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../../core/utils/Fonts.dart';

class FeaturedRestaurantsCard extends StatelessWidget {
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final String? image;
  final String? rating;
  final String? reviews;
  final String? restaurantName;
  final String? categories;
  final String? location;
  final String? price;
  final String? deliveryTime;
  final String? quantity;
  final String? startingPrice;

  const FeaturedRestaurantsCard({
    super.key,
    this.onAdd,
    this.onRemove,
    this.image,
    this.rating = "",
    this.reviews = "",
    this.restaurantName = "",
    this.categories = "",
    this.location = "",
    this.price = "",
    this.deliveryTime = "",
    this.quantity = "",
    this.startingPrice = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              CustomImage(
                source: image ?? Images.noImage,
                isNetwork: image == null ? false : true,
                height: 170.h,
                width: 140.w,
                borderRadius: BorderRadius.circular(12),
              ),
              Positioned(
                bottom: 0,
                child: CustomImage(
                  source: Images.gradient,
                  borderRadius: BorderRadius.circular(12.w),
                  height: 120.h,
                  width: 140.w,
                  // borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CustomImage(
                  source: Images.topRightShadow,
                  borderRadius: BorderRadius.circular(12.w),
                  height: 50.h,
                  width: 50.w,
                  isSvg: true,
                ),
              ),
              Positioned(
                right: 6.w,
                top: 6.h,
                child: CustomImage(
                  source: Images.heart,
                  isSvg: true,
                  height: 24.h,
                  width: 24.w,
                  color: AppColors.white,
                ),
              ),
              Positioned(
                bottom: 2.h,
                left: 8.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "ITEMS",
                      color: AppColors.white,
                      fontWeight: Fonts.bold,
                    ),
                    CustomText(
                      "AT ₹$startingPrice",
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: Fonts.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  restaurantName!,
                  maxLines: 2,
                  fontSize: 20.sp,
                  color: AppColors.textPrimary,
                  fontWeight: Fonts.bold,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    // Green star container
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star,
                        size: 14.sp,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 4.h),

                    // Rating & reviews
                    CustomText("$rating ($reviews)", fontSize: 16.sp),
                    SizedBox(width: 6.h),

                    // Dot separator
                    CustomText("•", fontSize: 16.sp),
                    SizedBox(width: 6.h),

                    // Delivery time
                    CustomText(deliveryTime!, fontSize: 16.sp),
                  ],
                ),
                SizedBox(height: 4.h),
                CustomText(
                  categories!,
                  maxLines: 2,
                  fontSize: 14.sp,
                  fontWeight: Fonts.light,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
