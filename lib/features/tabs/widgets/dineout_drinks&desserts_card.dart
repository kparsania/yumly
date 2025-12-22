import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../../core/utils/Fonts.dart';

class DrinksDessertsCard extends StatelessWidget {
  final String? image;
  final String? rating;
  final String? reviews;
  final String? restaurantName;
  final String? cuisine;
  final String? location;
  final String? price;
  final String? offers;

  const DrinksDessertsCard({
    super.key,
    this.image,
    this.rating = "",
    this.reviews = "",
    this.restaurantName = "",
    this.cuisine = "",
    this.location = "",
    this.price = "",
    this.offers = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.h),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.w),
                topLeft: Radius.circular(16.w),
              ),
              child: CustomImage(
                fit: BoxFit.cover,
                source: image,
                isNetwork: true,
                height: 170.h,
                width: 350.w,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16.w),
                  bottomLeft: Radius.circular(16.w),
                ),
                child: CustomImage(
                  source: Images.whiteCurveBackground,
                  height: 8.5.h,
                  width: 310.w,
                  // color: AppColors.primary,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 16.w),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(16.w),
                        bottomLeft: Radius.circular(16.w),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            // vertical: 4.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      restaurantName ?? "",
                                      fontSize: 18.sp,
                                      // maxLines: 2,
                                      fontWeight: Fonts.semiBold,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(1.5),
                                        decoration: BoxDecoration(
                                          color: AppColors.green,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.star,
                                          size: 14,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        rating ?? "",
                                        fontSize: 18.sp,
                                        maxLines: 2,
                                        fontWeight: Fonts.semiBold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    location ?? "",
                                    fontWeight: Fonts.light,
                                    color: AppColors.secondary,
                                  ),
                                  SizedBox(width: 6.h),
                                ],
                              ),
                              CustomText(
                                cuisine ?? "",
                                fontWeight: Fonts.light,
                                color: AppColors.secondary,
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.lightPrimary, AppColors.white],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(16.w),
                              bottomLeft: Radius.circular(16.w),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 4.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomImage(source: Images.percentageOffer),
                                  CustomText(
                                    offers ?? "",
                                    fontWeight: Fonts.medium,
                                  ),
                                ],
                              ),
                              CustomText(
                                "+4 offers",
                                color: AppColors.primary,
                                fontWeight: Fonts.medium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
