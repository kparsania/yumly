import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class DineoutShimmer extends StatelessWidget {
  const DineoutShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          SizedBox(height: 70.h),
          SizedBox(
            width: double.infinity,
            height: 180.h,
            child: CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                autoPlayInterval: const Duration(milliseconds: 3000),
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.755,
                initialPage: 0,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 80.h,
                    width: 305.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 60.h),

          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          SizedBox(
            height: 200.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (a, b) => SizedBox(width: 8.w),
              itemBuilder: (a, index) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 200.h,
                  width: 155.w,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.w),
                      bottomRight: Radius.circular(16.w),
                      topLeft: Radius.circular(70.w),
                      topRight: Radius.circular(70.w),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 60.h),

          SizedBox(
            height: 200.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (_, __) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 115.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Featured restaurant list shimmer
          Column(
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
