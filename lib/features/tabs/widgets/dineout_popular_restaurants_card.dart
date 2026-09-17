import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../../core/utils/Fonts.dart';

class PopularRestaurantsCard extends StatelessWidget {
  final List<String>? image;
  final String? rating;
  final String? reviews;
  final String? restaurantName;
  final String? cuisine;
  final String? location;
  final String? price;
  final String? offers;
  final String? offerType;

  const PopularRestaurantsCard({
    super.key,
    this.image,
    this.rating = "",
    this.reviews = "",
    this.restaurantName = "",
    this.cuisine = "",
    this.location = "",
    this.price = "",
    this.offers = "",
    this.offerType = "",
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
        width: 290.w,
        // decoration: BoxDecoration(
        //   color: AppColors.white,
        //   borderRadius: BorderRadius.circular(16),
        //   boxShadow: [
        //     BoxShadow(
        //       color: AppColors.secondary.withOpacity(0.3),
        //       blurRadius: 8,
        //       spreadRadius: 5,
        //       offset: Offset(2, 2),
        //     ),
        //   ],
        // ),
        margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
        child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
        Column(
        children: [
        // ClipRRect(
        //   borderRadius: BorderRadius.only(
        //     topRight: Radius.circular(16.w),
        //     topLeft: Radius.circular(16.w),
        //   ),
        //   child: CustomImage(
        //     source: image,
        //     isNetwork: true,
        //     fit: BoxFit.cover,
        //     height: 220.h,
        //     width: double.infinity,
        //   ),
        // ),
        (image as List).length > 1
            ?
        ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.w),
            topLeft: Radius.circular(16.w),
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 220.h,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(
                milliseconds: 800,
              ),
            ),
            items: (image)?.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.w),
                      topLeft: Radius.circular(16.w),
                    ),
                    child: CustomImage(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.w),
                        topLeft: Radius.circular(16.w),
                      ),
                      source: imgUrl,
                      isNetwork: true,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ) : ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.w),
            topLeft: Radius.circular(16.w),
          ),
          child: CustomImage(
            source: image![0],
            isNetwork: true,
            fit: BoxFit.cover,
            height: 220.h,
            width: double.infinity,
          ),
        ),
        Container(height: 80.h),
    ],
    ),
    Container(
    height: 150.h,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black38,
    Colors.transparent,
    ],
    ),
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(16.w),
    bottomRight: Radius.circular(16.w),
    ),
    ),
    ),
    Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    margin: EdgeInsets.only(left: 8.w, right: 8.w),
    padding: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 8.w),
    width: width * 0.6,
    alignment: Alignment.bottomCenter,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [
    Color.fromRGBO(22, 68, 145, 1),
    Color.fromRGBO(95, 155, 237, 1),
    Color.fromRGBO(35, 66, 119, 1),
    Colors.transparent,
    ],
    ),
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12.w),
    ),
    ),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    CustomText(
    "WALK-IN OFFER",
    fontSize: 13.sp,
    fontWeight: Fonts.semiBold,
    color: AppColors.white,
    ),
    SizedBox(width: 6.w),
    Container(
    height: 1.h,
    width: 50.w,
    color: AppColors.white,
    ),
    ],
    ),
    CustomText(
    "$offers + 2 more ",
    fontSize: 16.sp,
    fontWeight: Fonts.bold,
    color: AppColors.white,
    ),
    ],
    ),
    ),
    Container(
    margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.w),
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
    alignment: Alignment.bottomCenter,
    decoration: BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(12.w),
    bottomRight: Radius.circular(12.w),
    bottomLeft: Radius.circular(12.w),
    ),
    ),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // LEFT SIDE
    Expanded(
    flex: 7,
    child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Restaurant Name
    CustomText(
    restaurantName ?? "",
    fontSize: 22.sp,
    fontWeight: Fonts.medium,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    ),
    SizedBox(height: 4.h),

    // Location
    CustomText(
    location ?? "",
    color: AppColors.textSecondary,
    fontSize: 16.sp,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    ),
    SizedBox(height: 4.h),

    // Cuisine row
    Row(
    children: [
    Icon(
    Icons.energy_savings_leaf_outlined,
    size: 14.w,
    color: AppColors.green,
    ),
    SizedBox(width: 2.w),
    CustomText(
    "100% Veg-only",
    fontSize: 12.sp,
    color: AppColors.green,
    ),
    SizedBox(width: 4.w),
    CustomText(
    "•",
    fontSize: 12.sp,
    color: AppColors.textSecondary,
    ),
    SizedBox(width: 4.w),
    Expanded(
    child: CustomText(
    cuisine ?? "",
    fontSize: 12.sp,
    color: AppColors.textSecondary,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    ),
    ),
    ],
    ),
    ],
    ),
    ),

    SizedBox(width: 4.w),

    // RIGHT SIDE
    Expanded(
    flex: 3,
    child: Container(
    // color: Colors.red,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    // Rating badge
    Container(
    padding: EdgeInsets.symmetric(
    horizontal: 6.w,
    vertical: 4.h,
    ),
    decoration: BoxDecoration(
    color: AppColors.green,
    borderRadius: BorderRadius.circular(8.w),
    ),
    child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    CustomText(
    rating ?? "",
    color: AppColors.white,
    fontSize: 18.sp,
    ),
    SizedBox(width: 3.w),
    Icon(
    Icons.star,
    color: AppColors.white,
    size: 18.w,
    ),
    ],
    ),
    ),
    SizedBox(height: 6.h),

    // Price
    CustomText(
    price ?? "",
    color: AppColors.textSecondary,
    fontSize: 14.sp,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ],
    )
    ,
    );
  }
}
